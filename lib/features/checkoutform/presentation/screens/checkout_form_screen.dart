import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({super.key});

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: Row(
        children: [
          Container(
            width: 240,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "synctrackr",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E60FF),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _sidebarTile(Icons.dashboard, "Dashboard"),
                _sidebarTile(Icons.people, "Visitors"),
                _sidebarTile(Icons.groups, "Visitors' Heads"),
                _sidebarTile(Icons.bar_chart, "Reports"),
                _sidebarTile(Icons.apps, "Others"),
                _sidebarTile(Icons.settings, "Settings"),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Container(
                  width: 684,
                  // height: 607,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF0075FF)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment Details",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            )),
                        const SizedBox(height: 4),
                        Text(
                          "All transactions are secure and encrypted",
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                        Container(
                          width: 644,
                          // height: 180,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF77A1D3),
                                Color(0xFF79CBCA),
                                Color(0xFFFDC3E8)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(1.5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Standard Plan",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      // width:124,
                                      height: 30,
                                      child: TextButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        label: const Text(
                                          "View Features",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: TextButton.styleFrom(
                                          // foregroundColor:
                                          // const Color(0xFF3E7FFF),
                                          backgroundColor:
                                              const Color(0xFF3E7FFF),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          textStyle:
                                              GoogleFonts.poppins(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "₹1,599/month",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Designed for growing businesses with multi-device support and advanced visitor validation.",
                                  style: GoogleFonts.poppins(
                                      fontSize: 11, color: Colors.black87),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "20% off Discount ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(
                                            text: "(Billed Yearly)",
                                            style: GoogleFonts.poppins(
                                                fontSize: 11,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "-₹2,400.00",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 600,
                                  child: DottedLine(
                                      dashColor: Color(0xFFBDBDBD),
                                      dashLength: 4,
                                      dashGapLength: 3),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total per year",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "₹8,300.00",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                buildTextField("Full Name"),
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      // Country Code Box
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 14),
                                        decoration: BoxDecoration(
                                          // color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: const Text(
                                          "+91",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: TextField(
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            hintText: "Phone",
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 14),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                buildTextField("Email"),
                                SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                  "assets/images/payment.png",
                                  height: 29,
                                  width: 240,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isChecked = !isChecked;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: isChecked
                                              ? const Color(0xFFE4F0FF)
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: const Color(0xFF2F80ED),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: isChecked
                                            ? const Center(
                                                child: Icon(
                                                  Icons.check,
                                                  size: 12,
                                                  color: Color(0xFF2F80ED),
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text.rich(
                                      TextSpan(
                                        text: "I agree to the ",
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                        children: [
                                          TextSpan(
                                            text: "Terms & conditions",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: const Color(0xFF0075FF),
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarTile(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF868686)),
      title: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 13),
      ),
    );
  }

  Widget buildTextField(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
