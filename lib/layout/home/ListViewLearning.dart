import 'package:flutter/material.dart';

class ListWithCard extends StatelessWidget {
  const ListWithCard({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<String>> listsData = [
      ['Item 1', 'Item 2', 'Item 3'],
      ['Item A', 'Item B', 'Item C', 'Item D'],
      ['Item X', 'Item Y', 'Item Z'],
      ['Item P', 'Item Q', 'Item R'],
      ['Item M', 'Item N', 'Item O'],
    ];

    return ListView.builder(
      itemCount: listsData.length,
      itemBuilder: (BuildContext context, int index) {
        return CardList(listData: listsData[index]);
      },
    );
  }
}

class CardList extends StatelessWidget {
  final List<String> listData;

  const CardList({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Group: ${listData[0]}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              leading: const Icon(Icons.group, color: Colors.white),
            ),
            const Divider(color: Colors.white70),
            ListView.builder(
              itemCount: listData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${listData[index]} clicked!'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ListTile(
                      leading:
                          const Icon(Icons.check_circle, color: Colors.white),
                      title: Text(
                        listData[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
