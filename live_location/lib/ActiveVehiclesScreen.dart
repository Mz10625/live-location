
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live_location/firebase_operations.dart';
import 'package:live_location/login.dart';
import 'package:live_location/map_screen.dart';

class ActiveVehiclesScreen extends StatefulWidget {
  const ActiveVehiclesScreen({super.key});

  @override
  State<ActiveVehiclesScreen> createState() => _ActiveVehiclesScreenState();
}

class _ActiveVehiclesScreenState extends State<ActiveVehiclesScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(''),
              accountEmail: Text(user?.email ?? '', style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person, color: Colors.black54,),
              ),
              decoration: const BoxDecoration(color: Color.fromRGBO(77, 176, 234, 0.45)),
            ),
            // ListTile(
            //   leading: const Icon(Icons.update),
            //   title: const Text('Update Password' ),
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdatePasswordPage()),);
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async{
                try {
                  await FirebaseAuth.instance.signOut();
                  if(mounted){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()),);
                  }
                } catch (e) {
                  print("Error signing out: $e");
                }
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  'Vehicles',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Garbage collection vehicles in your area',
                style: TextStyle(fontSize: 15, color: Color.fromRGBO(99, 111, 129, 1), fontWeight: FontWeight.w500, ),
              ),
            ),
            const SizedBox(height: 20.0),
            Column(
              children: [
                FutureBuilder<Map<String, dynamic>>(
                  future: fetchCombinedData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final combinedData = snapshot.data!;
                    final vehicles = combinedData['vehicles'] as List<Map<String, dynamic>>;
                    final wardsMap = combinedData['wards'] as Map<String, dynamic>;

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical, // Enables vertical scrolling
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal, // Enables horizontal scrolling
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: constraints.maxWidth, // Ensures the table stretches to screen width
                              ),
                              child: DataTable(
                                columnSpacing: 20,
                                headingRowColor: const WidgetStatePropertyAll(Color.fromRGBO(77, 176, 234, 0.45)),
                                columns: const [
                                  DataColumn(label: Text('Vehicle No.')),
                                  DataColumn(label: Text('Ward No.')),
                                  DataColumn(label: Text('Ward Name')),
                                  DataColumn(label: Text('Status')),
                                ],
                                rows: vehicles.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  var vehicle = entry.value;

                                  final wardName = wardsMap[vehicle['ward_no'].toString()] ?? 'Unknown';
                                  return DataRow(
                                    color: WidgetStatePropertyAll(
                                      index % 2 == 0
                                          ? const Color.fromRGBO(255, 255, 255, 1)
                                          : const Color.fromRGBO(240, 245, 249, 1),
                                    ),
                                    cells: [
                                      DataCell(Text('${vehicle['vehicle_no']}')),
                                      DataCell(Text('${vehicle['ward_no']}')),
                                      DataCell(Text(wardName)),
                                      DataCell(vehicle['status'] == 'Inactive' ? Text('${vehicle['status']}',style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),) : Text('${vehicle['status']}',style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),)),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    // shadowColor: Colors.indigo
                  ),
                  child: const Text(
                    'View Location',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white), // Text styling
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapScreen()),
                    );
                  },
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}