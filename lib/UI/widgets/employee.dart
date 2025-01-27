import 'package:dt/BLoC/employee_bloc.dart';
import 'package:dt/DATA/employee_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final EmployeeBloc _employeeBloc= EmployeeBloc();

  @override
  void dispose(){
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DukoreTech"),
      ),
      body: Container(
        child: StreamBuilder<List<EmployeeData>> (
          stream: _employeeBloc.employeeListStream,
          builder: (BuildContext context, AsyncSnapshot<List<EmployeeData>> snapshot){
            return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              return Card(
                elevation: 5.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "${snapshot.data[index].id}.",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Text(
                      "${snapshot.data[index].name}.",
                      style: TextStyle(fontSize: 18.0),
                      ),

                      Text(
                      "\$${snapshot.data[index].salary}.",
                      style: TextStyle(fontSize: 16.0),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_up),
                          color: Colors.green,
                          onPressed: (){
                            _employeeBloc.employeeSalaryIncrement.add(snapshot.data[index]);
                          },
                      ),
                      ),

                      Container(
                      child: IconButton(
                        icon: Icon(Icons.thumb_down),
                        color: Colors.red,
                        onPressed: (){
                          _employeeBloc.employeeSalaryDecrement.add(snapshot.data[index]);
                        },
                      ),
                      )

                      ],
                    ),
                  ),
                  
                  ],
                ),
              );
            },
            );
          },
        ),
        ),
    );
  }
}