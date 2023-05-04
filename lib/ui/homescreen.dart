// import 'package:family_tree_app/ui/navdrawer.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Row(
//                   children: [Text('Node ${1}'), InkWell(
//                     onTap: (){

//                     },
//                     child: Icon(Icons.add))],
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:graphview/GraphView.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final Graph graph = Graph()..isTree = true;
//   BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
//   @override
//   void initState() {
//     final node1 = Node.Id(1);
//     final node2 = Node.Id(2);
//     final node3 = Node.Id(3);
//     final node4 = Node.Id(4);
//     final node5 = Node.Id(5);
//     final node6 = Node.Id(6);
//     final node8 = Node.Id(7);
//     final node7 = Node.Id(8);
//     final node9 = Node.Id(9);
//     final node10 = Node.Id(10);
//     final node11 = Node.Id(11);
//     final node12 = Node.Id(12);

//     graph.addEdge(node1, node2);
//     graph.addEdge(node1, node3, paint: Paint()..color = Colors.red);
//     graph.addEdge(node1, node4, paint: Paint()..color = Colors.blue);
//     graph.addEdge(node2, node5);
//     graph.addEdge(node2, node6);
//     graph.addEdge(node6, node7, paint: Paint()..color = Colors.red);
//     graph.addEdge(node6, node8, paint: Paint()..color = Colors.red);
//     graph.addEdge(node4, node9);
//     graph.addEdge(node4, node10, paint: Paint()..color = Colors.black);
//     graph.addEdge(node4, node11, paint: Paint()..color = Colors.red);
//     graph.addEdge(node11, node12);

//     builder
//       ..siblingSeparation = (100)
//       ..levelSeparation = (150)
//       ..subtreeSeparation = (150)
//       ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_BOTTOM_TOP);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: InteractiveViewer(
//             constrained: false,
//             boundaryMargin: EdgeInsets.all(100),
//             minScale: 0.01,
//             maxScale: 5.6,
//             child: GraphView(
//               graph: graph,
//               algorithm:
//                   BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
//               paint: Paint()
//                 ..color = Colors.green
//                 ..strokeWidth = 1
//                 ..style = PaintingStyle.stroke,
//               builder: (Node node) {
//                 // I can decide what widget should be shown here based on the id
//                 var a = node.key!.value as int;
//                 return rectangleWidget(a);
//               },
//             )));
//   }

//   Widget rectangleWidget(int a) {
//     return InkWell(
//       onTap: () {
//         print('clicked');
//       },
//       child: Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(4),
//             boxShadow: [
//               BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
//             ],
//           ),
//           child: Text('Node $a')),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class FamilyTree extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Family Tree'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildFamilyMember('Grandparent'),
//             SizedBox(height: 32),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildFamilyMember('Parent 1'),
//                 _buildFamilyMember('Parent 2'),
//               ],
//             ),
//             SizedBox(height: 32),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildFamilyMember('Child 1'),
//                 _buildFamilyMember('Child 2'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFamilyMember(String name) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 50,
//           backgroundColor: Colors.blueGrey[100],
//           child: Text(
//             name.substring(0, 1),
//             style: TextStyle(fontSize: 36),
//           ),
//         ),
//         SizedBox(height: 16),
//         Text(name),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class FamilyTree extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Family Tree'),
//       ),
//       body: CustomPaint(
//         painter: TreePainter(),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // _buildFamilyMember('Grandparent'),
//               // SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildFamilyMember('Parent 1'),
//                   _buildFamilyMember('Parent 2'),
//                 ],
//               ),
//               // SizedBox(height: 32),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //   children: [
//               //     _buildFamilyMember('Child 1'),
//               //     _buildFamilyMember('Child 2'),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFamilyMember(String name) {
//     return Column(
//       children: [
//         Container(
//           width: 100,
//           height: 100,
//           child: Stack(
//             children: [
//               Positioned(
//                 left: 0,
//                 top: 50,
//                 bottom: 0,
//                 child: Container(
//                   width: 50,
//                   height: 1,
//                   color: Colors.grey[400],
//                 ),
//               ),
//               Positioned(
//                 left: 50,
//                 top: 0,
//                 bottom: 0,
//                 child: CircleAvatar(
//                   radius: 25,
//                   backgroundColor: Colors.blueGrey[100],
//                   child: Text(
//                     name.substring(0, 1),
//                     style: TextStyle(fontSize: 24),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16),
//         Text(name),
//       ],
//     );
//   }
// }

// class TreePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.grey[400]!
//       ..strokeWidth = 1.0;

//     //Draw vertical line for grandparent
//     canvas.drawLine(
//       Offset(size.width / 2, 0),
//       Offset(size.width / 4, size.height / 4),
//       paint,
//     );

//     // Draw horizontal lines for parents
//     // canvas.drawLine(
//     //   Offset(size.width / 4, size.height / 3),
//     //   Offset(3 * size.width / 4, size.height / 3),
//     //   paint,
//     // );

//     // Draw vertical lines for children
//     // canvas.drawLine(
//     //   Offset(size.width / 4, size.height / 3),
//     //   Offset(size.width / 4, size.height),
//     //   paint,
//     // );
//     // canvas.drawLine(
//     //   Offset(3 * size.width / 4, size.height / 3),
//     //   Offset(3 * size.width / 4, size.height),
//     //   paint,
//     // );
//   }

//   @override
//   bool shouldRepaint(TreePainter oldDelegate) => false;
// }

// import 'package:flutter/material.dart';

// class FamilyTree extends StatefulWidget {
//   @override
//   _FamilyTreeState createState() => _FamilyTreeState();
// }

// class _FamilyTreeState extends State<FamilyTree> {
//   final List<Person> parents = [
//     Person('John'),
//     Person('Jane'),
//     Person('Bob'),
//     Person('Alice'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Family Tree'),
//       ),
//       body: CustomPaint(
//         painter: _TreePainter(parents),
//         child: ListView.builder(
//           itemCount: parents.length,
//           itemBuilder: (BuildContext context, int index) {
//             final parent = parents[index];
//             return ListTile(
//               title: Text(parent.name),
//               onTap: () => _showSpouseDialog(parent),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   void _showSpouseDialog(Person parent) async {
//     final TextEditingController controller = TextEditingController();
//     String spouseName = '';
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add Spouse'),
//           content: TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               labelText: 'Spouse Name',
//             ),
//             onChanged: (value) {
//               spouseName = value;
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final spouse = Person(spouseName);
//                 parent.spouse = spouse;
//                 setState(() {});
//                 Navigator.pop(context);
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _TreePainter extends CustomPainter {
//   final List<Person> parents;

//   _TreePainter(this.parents);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = Colors.grey
//       ..strokeWidth = 2.0;

//     for (int i = 0; i < parents.length; i += 2) {
//       final parent1 = parents[i];
//       final parent2 = i + 1 < parents.length ? parents[i + 1] : null;
//       if (parent2 != null) {
//         final parent1Offset = _getOffsetForParent(i, size);
//         final parent2Offset = _getOffsetForParent(i + 1, size);
//         canvas.drawLine(
//           Offset(parent1Offset.dx + 40, parent1Offset.dy),
//           Offset(parent2Offset.dx - 40, parent2Offset.dy),
//           paint,
//         );
//       }
//     }
//   }

//   Offset _getOffsetForParent(int index, Size size) {
//     final int row = index ~/ 2;
//     final int col = index % 2;
//     final double x = (size.width / 2) * (col + 1);
//     final double y = (size.height / 5) * (row + 1);
//     return Offset(x, y);
//   }

//   @override
//   bool shouldRepaint(_TreePainter oldDelegate) => true;
// }

// class Person {
//   final String name;
//   late Person spouse;

//   Person(this.name);
// }

// void main() {
//   runApp(MaterialApp(
//     title: 'Family Tree App',
//     home: FamilyTree(),
//   ));
// }
// import 'package:flutter/material.dart';

// class FamilyTree extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Family Tree'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 _buildPerson('Father'),
//                 SizedBox(width: 40.0),
//                 _buildPerson('Mother'),
//               ],
//             ),
//             SizedBox(height: 40.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 _buildPerson('Child 1'),
//                 _buildPerson('Child 2'),
//                 _buildPerson('Child 3'),
//               ],
//             ),
//             SizedBox(height: 40.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   width: 1.0,
//                   height: 40.0,
//                   color: Colors.grey,
//                 ),
//                 SizedBox(width: 20.0),
//                 Container(
//                   width: 1.0,
//                   height: 40.0,
//                   color: Colors.grey,
//                 ),
//               ],
//             ),
//             SizedBox(height: 20.0),
//             Container(
//               width: 1.0,
//               height: 40.0,
//               color: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPerson(String name) {
//     return Column(
//       children: <Widget>[
//         Container(
//           width: 100.0,
//           height: 100.0,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.blue,
//           ),
//           child: Center(
//             child: Text(
//               name,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20.0,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           width: 1.0,
//           height: 40.0,
//           color: Colors.grey,
//         ),
//       ],
//     );
//   }
// }

import 'dart:math';

import 'package:family_tree_app/ui/circleavatardemo.dart';
import 'package:family_tree_app/ui/roughshreach.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class FamilyTree extends StatefulWidget {
  const FamilyTree({super.key});

  @override
  _FamilyTreeState createState() => _FamilyTreeState();
}

class _FamilyTreeState extends State<FamilyTree> {
  double _scale = 1.0;
  get name => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: const Icon(Icons.abc),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CircleAvatarLine()));
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: const Icon(Icons.abc),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Rough()));
                },
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _scale *= 1.5;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _scale /= 1.5;
                    });
                  },
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
            Expanded(
              child: InteractiveViewer(
                  scaleEnabled: false,
                  transformationController: TransformationController()
                    ..value = Matrix4.diagonal3Values(_scale, _scale, 1),
                  constrained: false,
                  boundaryMargin: const EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // Create a new Node object for each node ID
                      final nodeKey = node.key!.value as int?;
                      final nodeObject = Node.Id(nodeKey!);

                      return rectangleWidget(nodeObject);
                    },
                  )),
            ),
          ],
        ));
  }

  Random r = Random();

  Widget rectangleWidget(Node node) {
    return InkWell(
      onTap: () {
        // Create a new node with a unique ID
        final newNode = Node.Id(graph.nodeCount() + 1);

        // Add the new node as a child to the clicked node
        graph.addEdge(node, newNode);

        // Update the graph
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Node ${node.key!.value}'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final newNode = Node.Id(graph.nodeCount() + 1);

                graph.addEdge(node, newNode);

                setState(() {});
              },
              child: const Text('Add child'),
            ),
          ],
        ),
      ),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    final node1 = Node.Id(1);

    graph.addNode(node1);

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (100)
      ..subtreeSeparation = (10)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}
