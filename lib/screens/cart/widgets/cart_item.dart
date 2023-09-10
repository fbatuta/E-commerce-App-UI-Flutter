import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatefulWidget {
  final CartItem cartItem;

  const CartItem({
    super.key,
    required this.cartItem,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.30,
            height: size.height * 0.13,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
                child: Image.asset(
                    'assets/images/${widget.cartItem.product.id}.png')),
          ),
          SizedBox(
            width: size.width * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cartItem.product.title,
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                /*
                Column(
                  children: [
                    Text(
                      'Probability: % ${context.read<CartProvider>().getTicketProbabilityPercentual(widget.cartItem.id).toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                */
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  "\$${widget.cartItem.product.price}",
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: size.width * 0.035,
                  ),
                ),
                SizedBox(
                  height: size.width * 0.030,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context
                            .read<CartController>()
                            .incrementQty(widget.cartItem.id);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.pink,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Iconsax.add,
                          color: Colors.pink,
                          size: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Text(
                      widget.cartItem.quantity.toString(),
                      style: GoogleFonts.poppins(),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<CartController>()
                            .decrimentQty(widget.cartItem.id);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.pink,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Iconsax.minus,
                          color: Colors.pink,
                          size: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<CartController>().removeItem(widget.cartItem.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color.fromARGB(255, 247, 247, 247),
                  content: Text(
                    "Item removed!",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.redAccent.withOpacity(0.07),
              radius: 18,
              child: const Icon(
                Iconsax.trash,
                color: Colors.redAccent,
                size: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
