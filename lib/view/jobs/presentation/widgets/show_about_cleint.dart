import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../../../../core/common widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/models/assigned_jobs_model.dart';
import '../../../../models/available_jobs_model.dart';

// -------------------------------------------------------------
// ASSIGNED JOB POPUP (NO CHANGE)
// -------------------------------------------------------------
void ShowAboutClientforassignedJob(BuildContext context, Job job) {
  final Client? client = job.client;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(20),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Client Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),

                if (client != null) _clientCardAssigned(client),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ReuseableGradientButton(
                    width: MediaQuery.of(context).size.width / 3,
                    title: "Yes, I Understand",
                    onpress: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _clientCardAssigned(Client client) {
  return Container(
    padding: const EdgeInsets.all(14),
    margin: const EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (client.diagnosis.isNotEmpty) ...[
          _title("Diagnosis"),
          _bulletList(_cleanList(client.diagnosis)),
        ],
        if (client.allergies.isNotEmpty) ...[
          _title("Allergies"),
          _bulletList(_cleanList(client.allergies)),
        ],
      ],
    ),
  );
}

// -------------------------------------------------------------
// ✅ AVAILABLE JOB POPUP (MOBILE REMOVED)
// -------------------------------------------------------------
void ShowAboutClientforAvailableJob(BuildContext context, Jobs job) {
  final Clients client = job.client;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(20),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Client Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ Mobile removed
                _clientCardAvailable(client),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ReuseableGradientButton(
                    width: MediaQuery.of(context).size.width / 3,
                    title: "Yes, I Understand",
                    onpress: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _clientCardAvailable(Clients client) {
  return Container(
    padding: const EdgeInsets.all(14),
    margin: const EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ❌ Mobile field removed from UI

        if (client.diagnosis.isNotEmpty) ...[
          _title("Diagnosis"),
          _bulletList(_cleanList(client.diagnosis)),
        ],

        if (client.allergies.isNotEmpty) ...[
          _title("Allergies"),
          _bulletList(_cleanList(client.allergies)),
        ],
      ],
    ),
  );
}

// -------------------------------------------------------------
// HELPERS
// -------------------------------------------------------------
Widget _title(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 4),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _value(String? text) {
  return Text(
    text ?? "N/A",
    style: const TextStyle(fontSize: 14),
  );
}

Widget _bulletList(List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items
        .map(
          (e) => Row(
        children: [
          const Text("• "),
          Expanded(child: Text(e.trim())),
        ],
      ),
    )
        .toList(),
  );
}

// Convert ["["A","B"]"] → ["A","B"]
List<String> _cleanList(List<dynamic> rawList) {
  try {
    if (rawList.isNotEmpty && rawList.first is String) {
      String cleaned = rawList.first
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '');
      return cleaned.split(',');
    }
  } catch (_) {}
  return [];
}
