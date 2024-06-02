import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListService extends StatefulWidget {
  final int index;
  final String text;
  final int selectedIndex;
  final Function(int) onSelected;

  const ListService(
      {super.key,
      required this.index,
      required this.text,
      required this.selectedIndex,
      required this.onSelected});

  @override
  State<ListService> createState() => _ListServiceState();
}

class _ListServiceState extends State<ListService> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelected(widget.index);
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
          width: 100,
          height: 30,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.selectedIndex == widget.index
                    ? const Color(0xFF9AC3FF) // Đầu gradient color
                    : Colors.transparent,
                widget.selectedIndex == widget.index
                    ? const Color(0xFF93A6FD) // Cuối gradient color
                    : Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(50),
            color: widget.selectedIndex == widget.index
                ? const Color(0xFF92A3FD)
                : Colors.transparent,
            border: widget.selectedIndex == widget.index
                ? null
                : Border.all(color: const Color(0xFF92A3FD), width: 1),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.selectedIndex == widget.index
                  ? Colors.white
                  : const Color(0xFF92A3FD),
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            // Thêm dấu ba chấm nếu văn bản quá dài
            maxLines: 1,
          )),
    );
  }
}
