import 'package:flutter/material.dart';

class Legend extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const Legend({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildLegendItem('assets/images/Rectangle-27.png', 'Available'),
        _buildLegendItem('assets/images/Rectangle-29.png', 'Selected'),
        _buildLegendItem('assets/images/Rectangle-28.png', 'Booked'),
      ],
    );
  }

  Widget _buildLegendItem(String assetPath, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * 0.08,
          height: screenHeight * 0.035,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(assetPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color.fromRGBO(39, 66, 129, 1),
          ),
        ),
      ],
    );
  }
}
