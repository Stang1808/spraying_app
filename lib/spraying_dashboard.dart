import 'package:flutter/material.dart';

class SprayingDashboard extends StatefulWidget {
  const SprayingDashboard({super.key});

  @override
  State<SprayingDashboard> createState() => _SprayingDashboardState();
}

class _SprayingDashboardState extends State<SprayingDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _modules = [
    {"title": "Chemical Inventory", "icon": Icons.inventory_2},
    {"title": "Spray Instructions", "icon": Icons.description},
    {"title": "Spray Schedule", "icon": Icons.calendar_month},
    {"title": "Spray Records / History", "icon": Icons.history},
    {"title": "Block Management", "icon": Icons.crop},
    {"title": "Weather & Safety", "icon": Icons.cloud},
    {"title": "Machinery Logs", "icon": Icons.agriculture},
    {"title": "Operator Management", "icon": Icons.people},
    {"title": "Reports & Analytics", "icon": Icons.bar_chart},
    {"title": "Alerts & Notifications", "icon": Icons.notifications},
    {"title": "Settings", "icon": Icons.settings},
  ];

  void _onSelectModule(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pop(context); // Close drawer on mobile
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F9FF),
      drawer: isMobile ? _buildSidebar() : null,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        leading: isMobile
            ? IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              )
            : null,
        title: const Text("Spraying App",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          _buildTopButton("User (+)", () {}),
          const SizedBox(width: 10),
          _buildTopButton("Farm (+)", () {}),
          const SizedBox(width: 10),
          _buildTopButton("Database (+)", () {}),
          const SizedBox(width: 15),
        ],
      ),
      body: Row(
        children: [
          if (!isMobile) _buildSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "📌 ${_modules[_selectedIndex]["title"]} Page",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
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

  /// Sidebar layout
  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.transparent,
      child: Column(
        children: [
          // SPRAYING APP tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D47A1),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "SPRAYING APP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // DASHBOARD + menu buttons
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "DASHBOARD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),

                    Expanded(
                      child: ListView.builder(
                        itemCount: _modules.length,
                        itemBuilder: (context, index) {
                          return _buildSidebarButton(
                            _modules[index]["icon"],
                            _modules[index]["title"],
                            () => _onSelectModule(index),
                          );
                        },
                      ),
                    ),

                    // Logout fixed at bottom
                    const Divider(color: Colors.white54),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D47A1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ).copyWith(
                          overlayColor: WidgetStateProperty.all(
                            Colors.blue.shade700,
                          ),
                        ),
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        onPressed: () {
                          // TODO: Add Firebase logout if needed
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Sidebar button style
  Widget _buildSidebarButton(
      IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(
            Colors.blue.shade700,
          ),
        ),
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  /// Top AppBar buttons
  Widget _buildTopButton(String title, VoidCallback onTap) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF1976D2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ).copyWith(
        overlayColor: WidgetStateProperty.all(
          Colors.blue.shade700,
        ),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
