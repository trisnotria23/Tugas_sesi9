import 'package:flutter/material.dart';

class Gridviewlearning extends StatelessWidget {
  const Gridviewlearning({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listsData = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: listsData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom
          mainAxisSpacing: 10, // Jarak vertikal antar elemen
          crossAxisSpacing: 10, // Jarak horizontal antar elemen
          childAspectRatio: 1, // Proporsi ukuran elemen
        ),
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Sudut melengkung
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  listsData[index],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
