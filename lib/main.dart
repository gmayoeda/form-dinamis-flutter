// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SOF(),
    );
  }
}

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<PersonEntry> persons = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(persons.toString()),
//             ElevatedButton(
//               child: const Text('Add entries'),
//               onPressed: () async {
//                 persons = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const SOF(),
//                   ),
//                 );
//                 if (persons != null) persons.forEach(print);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SOF extends StatefulWidget {
  const SOF({super.key});

  @override
  State<SOF> createState() => _SOFState();
}

class _SOFState extends State<SOF> {
  var nameTECs = <TextEditingController>[];
  var ageTECs = <TextEditingController>[];
  var jobTECs = <TextEditingController>[];
  var cards = <Card>[];
  List<PersonEntry> entries = [];

  Card createCard() {
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var jobController = TextEditingController();
    nameTECs.add(nameController);
    ageTECs.add(ageController);
    jobTECs.add(jobController);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Data ${cards.length + 1}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama')),
            TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Umur')),
            TextField(
                controller: jobController,
                decoration: const InputDecoration(labelText: 'Pekerjaan')),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cards.add(createCard());
  }

  _onDone() {
    entries = [];
    for (int i = 0; i < cards.length; i++) {
      if (nameTECs[i].text != '' ||
          ageTECs[i].text != '' ||
          jobTECs[i].text != '') {
        var name = nameTECs[i].text;
        var age = ageTECs[i].text;
        var job = jobTECs[i].text;
        entries.add(PersonEntry(name, age, job));
        setState(() {});

        nameTECs[i].text = '';
        ageTECs[i].text = '';
        jobTECs[i].text = '';

        print('DATA => $entries');
      } else {
        print('Data NULL!');
      }
    }
    // Navigator.pop(context, entries);
  }

  _onUpdate() {
    print(entries.length);
    for (int i = 0; i < entries.length; i++) {
      nameTECs[i].text = entries[i].name;
      ageTECs[i].text = entries[i].age;
      jobTECs[i].text = entries[i].studyJob;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _onUpdate();
            },
            icon: const Icon(
              Icons.edit,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          listData(),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cards[index];
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text('add new'),
                    onPressed: () => setState(() => cards.add(createCard())),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _onDone, child: const Icon(Icons.done)),
    );
  }

  Container listData() {
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: entries.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final x = entries[index];
          return Card(
            child: ListTile(
              title: Text(x.name),
              subtitle: Text('${x.age} - ${x.studyJob} '),
            ),
          );
        },
      ),
    );
  }
}

class PersonEntry {
  final String name;
  final String age;
  final String studyJob;

  PersonEntry(this.name, this.age, this.studyJob);
  @override
  String toString() {
    return 'Person: name= $name, age= $age, study job= $studyJob';
  }
}
