import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

  // User data - in a real app, this would come from a database
  String username = 'Parth Kailas Bhamare';
  String mobile = '7039088088';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    usernameController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 800;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1a1a1a),
              const Color(0xFF2d2d2d),
              const Color(0xFF1f1f1f),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                _buildAppBar(screenWidth, isTablet),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: _getHorizontalPadding(screenWidth),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          _buildProfileHeader(screenWidth, isTablet),
                          SizedBox(height: screenHeight * 0.04),
                          _buildProfileCard(screenWidth, isTablet, isLargeScreen),
                          SizedBox(height: screenHeight * 0.03),
                          _buildActionButtons(screenWidth, isTablet),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth > 800) return 60.0; // Large tablets/foldables
    if (screenWidth > 600) return 40.0; // Tablets
    if (screenWidth > 400) return 20.0; // Large phones
    return 16.0; // Small phones
  }

  Widget _buildAppBar(double screenWidth, bool isTablet) {
    final iconSize = isTablet ? 24.0 : 20.0;
    final titleSize = isTablet ? 28.0 : 24.0;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            constraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
              maxWidth: 56,
              maxHeight: 56,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF444444), width: 1),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: iconSize,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            constraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
              maxWidth: 56,
              maxHeight: 56,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF444444), width: 1),
            ),
            child: IconButton(
              onPressed: _showEditProfileDialog,
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(double screenWidth, bool isTablet) {
    final avatarSize = isTablet ? 120.0 : screenWidth * 0.25;
    final iconSize = isTablet ? 60.0 : avatarSize * 0.5;
    final nameSize = isTablet ? 28.0 : screenWidth * 0.06;
    final emailSize = isTablet ? 16.0 : screenWidth * 0.035;

    return Column(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4CAF50),
                Color(0xFF45a049),
              ],
            ),
            border: Border.all(color: const Color(0xFF333333), width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            Icons.person,
            size: iconSize,
            color: Colors.white,
          ),
        ),
        SizedBox(height: screenWidth * 0.04),
        Text(
          username,
          style: TextStyle(
            color: Colors.white,
            fontSize: nameSize.clamp(20.0, 32.0),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: screenWidth * 0.02),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenWidth * 0.015,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF333333),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF444444), width: 1),
          ),
          child: Text(
            currentUser.email!,
            style: TextStyle(
              color: const Color(0xFFB0B0B0),
              fontSize: emailSize.clamp(12.0, 18.0),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(double screenWidth, bool isTablet, bool isLargeScreen) {
    final cardPadding = isTablet ? 32.0 : screenWidth * 0.06;
    final titleSize = isTablet ? 24.0 : screenWidth * 0.05;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: isLargeScreen ? 600 : double.infinity,
      ),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF3a3a3a), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: TextStyle(
              fontSize: titleSize.clamp(18.0, 28.0),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4CAF50),
            ),
          ),
          SizedBox(height: screenWidth * 0.05),
          _buildInfoRow(Icons.person_outline, 'Username', username, screenWidth, isTablet),
          SizedBox(height: screenWidth * 0.04),
          _buildInfoRow(Icons.email_outlined, 'Email', currentUser.email!, screenWidth, isTablet),
          SizedBox(height: screenWidth * 0.04),
          _buildInfoRow(Icons.phone_outlined, 'Mobile', mobile, screenWidth, isTablet),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, double screenWidth, bool isTablet) {
    final iconSize = isTablet ? 24.0 : screenWidth * 0.05;
    final labelSize = isTablet ? 14.0 : screenWidth * 0.03;
    final valueSize = isTablet ? 18.0 : screenWidth * 0.04;
    final iconContainerSize = isTablet ? 48.0 : screenWidth * 0.1;

    return Row(
      children: [
        Container(
          width: iconContainerSize,
          height: iconContainerSize,
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3), width: 1),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF4CAF50),
            size: iconSize.clamp(16.0, 28.0),
          ),
        ),
        SizedBox(width: screenWidth * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: labelSize.clamp(10.0, 16.0),
                  color: const Color(0xFF888888),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                value,
                style: TextStyle(
                  fontSize: valueSize.clamp(14.0, 20.0),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(double screenWidth, bool isTablet) {
    final buttonHeight = isTablet ? 56.0 : screenWidth * 0.12;
    final fontSize = isTablet ? 18.0 : screenWidth * 0.04;
    final iconSize = isTablet ? 24.0 : screenWidth * 0.045;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: buttonHeight.clamp(48.0, 64.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF45a049)],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4CAF50).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _showEditProfileDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.white, size: iconSize.clamp(16.0, 28.0)),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize.clamp(14.0, 20.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog() {
    usernameController.text = username;
    mobileController.text = mobile;

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2a2a2a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF3a3a3a), width: 1),
          ),
          title: Row(
            children: [
              Icon(Icons.edit, color: const Color(0xFF4CAF50), size: isTablet ? 28 : 24),
              const SizedBox(width: 8),
              Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: isTablet ? 24.0 : 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: screenWidth > 600 ? 400 : screenWidth * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogTextField(
                  controller: usernameController,
                  label: 'Username',
                  icon: Icons.person_outline,
                  isTablet: isTablet,
                ),
                const SizedBox(height: 16),
                _buildDialogTextField(
                  controller: mobileController,
                  label: 'Mobile Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  isTablet: isTablet,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: const Color(0xFF888888),
                  fontSize: isTablet ? 16.0 : 14.0,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  username = usernameController.text.trim();
                  mobile = mobileController.text.trim();
                });
                Navigator.of(context).pop();
                _showSuccessSnackBar('Profile updated successfully!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 16.0 : 14.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    required bool isTablet,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: Colors.white,
        fontSize: isTablet ? 16.0 : 14.0,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: const Color(0xFF888888),
          fontSize: isTablet ? 16.0 : 14.0,
        ),
        prefixIcon: Icon(icon, color: const Color(0xFF4CAF50), size: isTablet ? 24 : 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF444444)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF444444)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFF333333),
      ),
    );
  }


  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      ),
    );
  }
}