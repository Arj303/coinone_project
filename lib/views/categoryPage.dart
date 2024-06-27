import 'package:flutter/material.dart';
import 'package:machientest/model/productsModel.dart';
import 'package:machientest/services/api_services.dart';
import 'package:machientest/views/subCategoryPage.dart';
import 'package:provider/provider.dart';

import '../providers/profile_providers.dart';

class ImageCardScreen extends StatefulWidget {
  @override
  _ImageCardScreenState createState() => _ImageCardScreenState();
}

class _ImageCardScreenState extends State<ImageCardScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Products>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = apiService.fetchTemplateCategories();
    Provider.of<UserController>(context,listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final controller=Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Welcome ${controller.name} - Categories",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      body: FutureBuilder<List<Products>>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          }

          final categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final imgUrlPath = category.imgUrlPath;
              final imageUrl = '${ApiService.baseUrl}$imgUrlPath';
              final name = category.name;

              return GestureDetector(
                onTap: () {
                  // ImageGridPage
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ImageGridPage(categoryId: category.id);
                    },
                  ));
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.network(imageUrl),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
