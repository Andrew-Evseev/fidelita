import 'package:flutter/material.dart';

class AdminDataTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final bool isLoading;

  const AdminDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: DataTable(
          columns: columns,
          rows: rows,
          headingRowColor: MaterialStateProperty.all(
            const Color(0xFFFAF8F5),
          ),
          dataRowColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const Color(0xFF8B7355).withOpacity(0.1);
              }
              return Colors.white;
            },
          ),
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B7355),
          ),
          dataTextStyle: const TextStyle(
            color: Colors.black87,
          ),
          border: TableBorder(
            horizontalInside: BorderSide(
              color: Colors.grey[200]!,
            ),
          ),
        ),
      ),
    );
  }
}