import 'package:flutter/material.dart';

class ItemCar extends StatelessWidget {
  const ItemCar({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size;
    return SizedBox(
    
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpToByUdRTAazhtRVmMVtt97q1J_GO026tuA&usqp=CAU',
                // width: double.maxFinite,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Lamborghini Sport Car aaaaaaaaaaaa',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_half_rounded),
              Text('4.5'),
              SizedBox(width: 12),
              Text('|'),
              SizedBox(width: 12),
              Container(
                padding: EdgeInsets.all(4),
                
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.grey,
                  
                ),
                child: Text('New'),
              )
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '\$199.000/day',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
