import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required this.onTapSearch,
    required this.onTapCart,
  });

  final VoidCallback onTapSearch;
  final VoidCallback onTapCart;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: onTapSearch,
        radius: 120,
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: kToolbarHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Search Items',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).cardColor,
                  child: IconButton(
                    onPressed: onTapCart,
                    
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
