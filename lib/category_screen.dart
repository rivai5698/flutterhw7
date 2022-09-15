import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhw7/category_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryCubit _categoryCubit = CategoryCubit();
  @override
  void initState() {
    _categoryCubit.createListCategory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        bloc: _categoryCubit,
        builder: (_, state) {
          // if(state is CategoryGettingState){
          //   return const Center(
          //     child: Text('Loading...'),
          //   );
          // }
          if (state is CategoryGetFailState) {
            return const Center(
              child: Text('Failed'),
            );
          }
          if (state is CategoryGettingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoryGetSuccessState &&
              _categoryCubit.listCategory.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 160,
                  crossAxisSpacing: 20),
              itemBuilder: (_, index) {
                return CategoryItem(
                    categoryModel: _categoryCubit.listCategory[index]);
              },
              itemCount: _categoryCubit.listCategory.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryItem({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          categoryModel.urlPicture ?? '',
          loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
            if(loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (_, Object error, StackTrace? stacktrace) {
            return const Text('Error');
          },
          width: 80,
          height: 80,
        ),
        Text(categoryModel.name ?? ''),
      ],
    );
  }
}
