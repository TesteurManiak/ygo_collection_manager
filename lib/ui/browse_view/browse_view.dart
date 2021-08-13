import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/sets_bloc.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class BrowseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _setsBloc = BlocProvider.of<SetsBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Browse')),
      body: StreamBuilder<List<SetModel>?>(
        stream: _setsBloc.onSetsChanged,
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString());
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => ListTile(
              title: Text(snapshot.data![index].setName),
              subtitle: Text(snapshot.data![index].setCode),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}
