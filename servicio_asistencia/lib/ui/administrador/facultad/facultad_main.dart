import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicio_asistencia/bloc/facultad/facultad_bloc.dart';
import 'package:servicio_asistencia/comp/TabItem.dart';
import 'package:servicio_asistencia/repositories/FacultadRepository.dart';
import 'package:servicio_asistencia/ui/administrador/facultad/facultad_edit.dart';
import 'package:servicio_asistencia/ui/administrador/facultad/facultad_form.dart';
import 'package:servicio_asistencia/models/facultad/FacultadModelo.dart';
import 'package:servicio_asistencia/theme/AppTheme.dart';
import 'package:servicio_asistencia/ui/administrador/facultad/scanerqr.dart';
import 'package:servicio_asistencia/ui/help_screen.dart';

class MainFacultadF extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FacultadBloc(FacultadRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: AppTheme.themeData,
        home: FacultadUI(),
      ),
    );
  }
}

class FacultadUI extends StatefulWidget {
  @override
  _FacultadUIState createState() => _FacultadUIState();
}

class _FacultadUIState extends State<FacultadUI> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FacultadBloc>(context).add(ListarFacultadEvent());
  }

  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();

  Future onGoBack(dynamic value) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Facultades'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("Si funciona");
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("Si funciona 2");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FacultadForm()),
                  ).then(onGoBack);
                },
                child: Icon(Icons.add_box_sharp),
              ),
            )
          ],
        ),
        backgroundColor: AppTheme.nearlyWhite,
        body: BlocBuilder<FacultadBloc, FacultadState>(
          builder: (context, state) {
            if (state is FacultadLoadedState) {
              return _buildListView(state.facultadList);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        bottomNavigationBar: _buildBottomTab(),
        floatingActionButton: AnimatedFloatingActionButton(
          key: key,
          fabButtons: <Widget>[
            add(),
            image(),
            inbox(),
          ],
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close,
        ),
      ),
    );
  }

  Widget _buildListView(List<FacultadModelo> facultades) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          FacultadModelo facultad = facultades[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        facultad.inicales,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        facultad.nombrefac,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/imagen/man-icon.png"),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: AppTheme.themeData.colorScheme.primary,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>FacultadFormEdit(modelF: facultad),
                                ),
                              ).then(onGoBack);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: AppTheme.themeData.colorScheme.primary,
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Mensaje de confirmacion"),
                                    content: Text("¿Desea eliminar?"),
                                    actions: [
                                      FloatingActionButton(
                                        child: const Text('CANCEL'),
                                        onPressed: () {
                                          Navigator.of(context).pop('Failure');
                                        },
                                      ),
                                      FloatingActionButton(
                                        child: const Text('ACCEPT'),
                                        onPressed: () {
                                          Navigator.of(context).pop('Success');
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ).then((value) {
                                if (value.toString() == "Success") {
                                  BlocProvider.of<FacultadBloc>(context).add(
                                    DeleteFacultadEvent(facultad),
                                  );
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.qr_code),
                            color: AppTheme.themeData.colorScheme.primary,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  MyCustomWidget(),
                                ),
                              ).then(onGoBack);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: facultades.length,
      ),
    );
  }

  int selectedPosition = 0;
  final tabs = ['Home', 'Profile', 'Help', 'Settings'];

  _buildBottomTab() {
    return BottomAppBar(
      color: AppTheme.themeData.colorScheme.primaryContainer,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            icon: Icons.menu,
            text: tabs[0],
            isSelected: selectedPosition == 0,
            onTap: () {
              setState(() {
                selectedPosition = 0;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HelpScreen();
              }));
            },
          ),
          TabItem(
            icon: Icons.person,
            text: tabs[1],
            isSelected: selectedPosition == 1,
            onTap: () {
              setState(() {
                selectedPosition = 1;
              });
            },
          ),
          TabItem(
            text: tabs[2],
            icon: Icons.help,
            isSelected: selectedPosition == 2,
            onTap: () {
              setState(() {
                selectedPosition = 2;
              });
            },
          ),
          TabItem(
            text: tabs[3],
            icon: Icons.settings,
            isSelected: selectedPosition == 3,
            onTap: () {
              setState(() {
                selectedPosition = 3;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          key.currentState?.closeFABs();
        },
        heroTag: Text("Image"),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: Text("Image"),
        tooltip: 'Image',
        child: Icon(Icons.image),
      ),
    );
  }

  Widget inbox() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: Text("Inbox"),
        tooltip: 'Inbox',
        child: Icon(Icons.inbox),
      ),
    );
  }
}
