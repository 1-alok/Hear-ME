import 'package:HearMe/API/saavn.dart';
import 'package:HearMe/Utils/audio_serviec.dart';
import 'package:HearMe/model/songModel.dart';
import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  TextEditingController searchController = new TextEditingController();
  ValueNotifier<List<SongModel>> songs = ValueNotifier<List<SongModel>>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(9, 18, 39, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TextField(
            onChanged: (value) async {
              if (value != "") {
                songs.value = await fetchSongsList(value);
              }
            },
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search",
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                songs.value = await fetchSongsList(searchController.text);
              },
            )
          ],
        ),
        body: ValueListenableBuilder<List<SongModel>>(
            valueListenable: songs,
            builder: (context, snapshot, child) {
              return ListView.builder(
                  itemCount: songs.value.length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: Colors.indigo[900],
                        child: ListTile(
                          title: Text(songs.value[index].title),
                          subtitle: Text(songs.value[index].artist),
                          leading: Image.network(songs.value[index].imageURL),
                          onTap: () async {
                            await initPlayList(songs.value, index);
                            // print(songs.value[index]);
                          },
                        ));
                  });
            }));
  }
}
