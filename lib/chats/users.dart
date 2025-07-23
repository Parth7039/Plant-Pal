import 'package:flutter/material.dart';
import 'package:medigard/ui_pages/homepage.dart';

import 'chat_page.dart';
import 'chat_service.dart';

class ChatUsers extends StatefulWidget {
  const ChatUsers({Key? key}) : super(key: key);

  @override
  State<ChatUsers> createState() => _ChatUsersState();
}

class _ChatUsersState extends State<ChatUsers> with TickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<double>? _fadeAnimation;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
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
            opacity: _fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
            child: Column(
              children: [
                _buildAppBar(screenWidth, isTablet),
                _buildSearchBar(screenWidth, isTablet),
                Expanded(
                  child: _buildUserList(screenWidth, screenHeight, isTablet),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(double screenWidth, bool isTablet) {
    final iconSize = isTablet ? 28.0 : 24.0;
    final titleSize = isTablet ? 32.0 : 28.0;

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
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: iconSize,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    color: const Color(0xFF4CAF50),
                    size: titleSize,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Chat Users',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.12), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildSearchBar(double screenWidth, bool isTablet) {
    final fontSize = isTablet ? 18.0 : 16.0;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2a2a2a),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color(0xFF3a3a3a), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
          decoration: InputDecoration(
            hintText: 'Search users...',
            hintStyle: TextStyle(
              color: const Color(0xFF888888),
              fontSize: fontSize,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: const Color(0xFF4CAF50),
              size: isTablet ? 28 : 24,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
              icon: Icon(
                Icons.clear,
                color: const Color(0xFF888888),
                size: isTablet ? 24 : 20,
              ),
            )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.03,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase();
            });
          },
        ),
      ),
    );
  }

  Widget _buildUserList(double screenWidth, double screenHeight, bool isTablet) {
    ChatService chatService = ChatService();

    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorState(screenWidth, isTablet);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState(screenWidth, isTablet);
        }

        List<Map<String, dynamic>> users = snapshot.data ?? [];

        // Filter users based on search query
        if (_searchQuery.isNotEmpty) {
          users = users.where((user) {
            final username = user["username"]?.toString().toLowerCase() ?? '';
            final email = user["email"]?.toString().toLowerCase() ?? '';
            return username.contains(_searchQuery) || email.contains(_searchQuery);
          }).toList();
        }

        if (users.isEmpty) {
          return _buildEmptyState(screenWidth, isTablet);
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 200 + (index * 50)),
                child: _buildUserListItem(
                  users[index],
                  context,
                  screenWidth,
                  isTablet,
                  index,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData,
      BuildContext context,
      double screenWidth,
      bool isTablet,
      int index,
      ) {
    final avatarSize = isTablet ? 60.0 : screenWidth * 0.12;
    final titleSize = isTablet ? 18.0 : screenWidth * 0.042;
    final subtitleSize = isTablet ? 14.0 : screenWidth * 0.035;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenWidth * 0.01,
        horizontal: screenWidth * 0.02,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData["email"],
                  receiverID: userData["uid"],
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2a2a2a),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF3a3a3a), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              children: [
                Hero(
                  tag: 'avatar_${userData["uid"]}',
                  child: Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          _getAvatarColor(userData["username"] ?? ''),
                          _getAvatarColor(userData["username"] ?? '').withOpacity(0.7),
                        ],
                      ),
                      border: Border.all(color: const Color(0xFF4CAF50), width: 2),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: avatarSize * 0.5,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData["username"] ?? 'Unknown User',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: titleSize.clamp(14.0, 22.0),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      Text(
                        userData["email"] ?? '',
                        style: TextStyle(
                          color: const Color(0xFF888888),
                          fontSize: subtitleSize.clamp(12.0, 16.0),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    color: const Color(0xFF4CAF50),
                    size: isTablet ? 24 : 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(double screenWidth, bool isTablet) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isTablet ? 80 : 60,
            height: isTablet ? 80 : 60,
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
              strokeWidth: 3.0,
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          Text(
            'Loading users...',
            style: TextStyle(
              color: const Color(0xFF888888),
              fontSize: isTablet ? 18.0 : 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(double screenWidth, bool isTablet) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFFF5252),
            size: isTablet ? 80 : 60,
          ),
          SizedBox(height: screenWidth * 0.04),
          Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 20.0 : 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            'Unable to load users',
            style: TextStyle(
              color: const Color(0xFF888888),
              fontSize: isTablet ? 16.0 : 14.0,
            ),
          ),
          SizedBox(height: screenWidth * 0.06),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Trigger rebuild to retry
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenWidth * 0.03,
              ),
            ),
            child: Text(
              'Retry',
              style: TextStyle(
                color: Colors.white,
                fontSize: isTablet ? 16.0 : 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(double screenWidth, bool isTablet) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchQuery.isNotEmpty ? Icons.search_off : Icons.people_outline,
            color: const Color(0xFF888888),
            size: isTablet ? 80 : 60,
          ),
          SizedBox(height: screenWidth * 0.04),
          Text(
            _searchQuery.isNotEmpty ? 'No users found' : 'No users available',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 20.0 : 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try searching with different keywords'
                : 'Users will appear here when available',
            style: TextStyle(
              color: const Color(0xFF888888),
              fontSize: isTablet ? 16.0 : 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          if (_searchQuery.isNotEmpty) ...[
            SizedBox(height: screenWidth * 0.06),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenWidth * 0.03,
                ),
              ),
              child: Text(
                'Clear Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 16.0 : 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getAvatarColor(String name) {
    final colors = [
      const Color(0xFF4CAF50),
      const Color(0xFF2196F3),
      const Color(0xFFFF9800),
      const Color(0xFF9C27B0),
      const Color(0xFFF44336),
      const Color(0xFF607D8B),
      const Color(0xFF795548),
      const Color(0xFF009688),
    ];

    int hash = 0;
    for (int i = 0; i < name.length; i++) {
      hash = name.codeUnitAt(i) + ((hash << 5) - hash);
    }

    return colors[hash.abs() % colors.length];
  }
}