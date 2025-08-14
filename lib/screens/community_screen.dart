import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import 'post/new_post_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // Sample banner items
  final List<String> _banners = [
    'assets/images/community_banner.png',
    'assets/images/community_banner.png',
    'assets/images/community_banner.png',
  ];

  // PageController for banner carousel
  late PageController _pageController;
  int _currentBannerIndex = 0;

  // Search functionality
  bool _isSearchMode = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _toggleSearchMode() {
    setState(() {
      _isSearchMode = !_isSearchMode;
      if (_isSearchMode) {
        // 검색 모드로 전환 시 포커스 설정
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _searchFocusNode.requestFocus();
        });
      } else {
        // 검색 모드 종료 시 텍스트 클리어
        _searchController.clear();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearchMode = false;
    });
  }

  void _onSearchSubmitted(String value) {
    // TODO: 검색 로직 구현
    print('검색어: $value');
  }

  // Sample feed posts
  final List<Post> _posts = List.generate(
    10,
    (i) => Post(
      author: 'User $i',
      avatarUrl: 'assets/icons/user.png',
      timeAgo: '${(i + 1) * 5}분 전',
      title: '게시글 제목 $i',
      excerpt: '게시글 내용 요약 예시 텍스트입니다. 최대 3줄 정도로 표시됩니다. 게시글 $i...',
      views: (i + 1) * 10,
      likes: (i + 1) * 2,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: _isSearchMode
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: '검색어를 입력하세요',
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: _clearSearch,
                        )
                      : null,
                ),
                onSubmitted: _onSearchSubmitted,
                onChanged: (value) {
                  setState(() {
                    // 텍스트 변경 시 UI 업데이트
                  });
                },
              )
            : const Text('아이바 (Aiva)'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: _isSearchMode
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _toggleSearchMode,
              )
            : null,
        actions: [
          if (!_isSearchMode)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _toggleSearchMode,
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner carousel
            SizedBox(
              height: 100,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: _banners.length,
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentBannerIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            _banners[index],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  // Page indicator
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _banners.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentBannerIndex == index
                                ? Colors.blue
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            // Feed list
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: _posts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final post = _posts[index];
                return _PostCard(post: post);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(currentIndex: 1),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewPostScreen()),
          );
        },
      ),
    );
  }
}

class Post {
  final String author;
  final String avatarUrl;
  final String timeAgo;
  final String title;
  final String excerpt;
  final int views;
  final int likes;
  Post({
    required this.author,
    required this.avatarUrl,
    required this.timeAgo,
    required this.title,
    required this.excerpt,
    required this.views,
    required this.likes,
  });
}

class _PostCard extends StatelessWidget {
  final Post post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to post detail
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 16,
                    backgroundImage: AssetImage(post.avatarUrl),
                    onBackgroundImageError: (exception, stackTrace) {
                      // 이미지 로드 실패 시 처리
                    },
                    child: post.avatarUrl.contains('user.png')
                        ? null
                        : Text(
                            post.author[0],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      post.author,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(post.timeAgo,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Text(post.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                post.excerpt,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.remove_red_eye,
                      size: 16, color: const Color(0xFFFFD24C)),
                  const SizedBox(width: 4),
                  Text(post.views.toString()),
                  const SizedBox(width: 16),
                  Icon(Icons.thumb_up_alt_outlined,
                      size: 16, color: const Color(0xFFFFD24C)),
                  const SizedBox(width: 4),
                  Text(post.likes.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
