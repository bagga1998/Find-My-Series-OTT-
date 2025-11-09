import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserReviewsScreen extends StatefulWidget {
  const UserReviewsScreen({super.key});

  @override
  State<UserReviewsScreen> createState() => _UserReviewsScreenState();
}

class _UserReviewsScreenState extends State<UserReviewsScreen> {
  String spoilerFilter = 'Spoilers';
  String ratingFilter = 'Review Rating';

  // Dummy review data
  final List<Map<String, dynamic>> reviews = [
    {
      'rating': 8,
      'title': 'Still not able to come out of the Kantara World...!!!',
      'review':
          'No words to explain... Outstanding Cinema. All departments hardwork shows in the screen. Aravind Kashyap cinematography is next level. BGM and Song from Ajaneesh gives goosebumps. The Director and Actor Rishabh Shetty is fire. Saptami Gowda did excellent and romantic part is very raw and goes with the story well. Kishore and Achyuth Sir perfect casting and brought justice to the role.',
      'likes': 253,
      'comments': 15,
      'author': 'Anonymous',
      'date': 'October 2, 2022',
      'spoiler': false,
    },
    {
      'rating': 8,
      'title': 'Went in for the hype, came out with Goosebumps',
      'review':
          'After hearing so much about this movie, went in without watching the trailer, but from the very beginning of the movie, boy was I glued to the screen.',
      'likes': 203,
      'comments': 10,
      'author': 'shymatheju',
      'date': 'October 2, 2022',
      'spoiler': true,
    },
  ];

  bool expandedIndex(int index) => expanded.contains(index);
  final Set<int> expanded = {};

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: 'BACK TO PREVIOUS PAGE',
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        showBackArrow: true,
        leadingOnPressed: Get.back,
        leadingIconSize: 18,
        leadingTextStyle: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: OTTColors.whiteColor,
        ),

        backgroundColor: Colors.transparent,
        elevation: 0,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF161218), Color(0xFF2B1D34)],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/background.svg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: Get.height * 0.030,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB968F0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'Cast',
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      Spacer(),
                      const Icon(
                        Icons.filter_list,
                        color: OTTColors.buttoncolour,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),

                  // Filters
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white24),
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              dropdownColor: Colors.black,
                              value: spoilerFilter,
                              items: ['Spoilers', 'No Spoilers']
                                  .map(
                                    (val) => DropdownMenuItem(
                                      value: val,
                                      child: Text(
                                        val,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) =>
                                  setState(() => spoilerFilter = val!),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white24),
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              dropdownColor: Colors.black,
                              value: ratingFilter,
                              items:
                                  [
                                        'Review Rating',
                                        'Most Recent',
                                        'Top Reviews',
                                      ]
                                      .map(
                                        (val) => DropdownMenuItem(
                                          value: val,
                                          child: Text(
                                            val,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) =>
                                  setState(() => ratingFilter = val!),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // Reviews List
                  Expanded(
                    child: ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        final isExpanded = expanded.contains(index);

                        return Container(
                          // margin: EdgeInsets.only(bottom: height * 0.02),
                          padding: EdgeInsets.all(width * 0.03),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Rating Row
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  Text(
                                    '${review['rating']}/10',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.01),

                              // Title
                              CustomText(
                                text: review['title'],
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DM Sans',
                              ),
                              SizedBox(height: height * 0.006),

                              // Date & Author
                              Text(
                                'by ${review['author']} • ${review['date']}',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              SizedBox(height: height * 0.01),

                              // Spoiler Warning
                              if (review['spoiler'])
                                const CustomText(
                                  text: 'WARNING: SPOILERS',
                                  color: Colors.redAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'DM Sans',
                                ),

                              SizedBox(height: height * 0.008),

                              // Review Text
                              CustomText(
                                text: isExpanded
                                    ? review['review']
                                    : '${review['review'].toString().substring(0, 120)}...',
                                color: Colors.white70,
                                fontFamily: 'DM Sans',
                                fontSize: 14,
                              ),
                              SizedBox(height: height * 0.006),

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isExpanded) {
                                      expanded.remove(index);
                                    } else {
                                      expanded.add(index);
                                    }
                                  });
                                },
                                child: CustomText(
                                  text: isExpanded ? 'Show Less' : 'See More',
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              SizedBox(height: height * 0.01),

                              // Likes & Comments Row
                              Row(
                                children: [
                                  const Icon(
                                    Icons.thumb_up_alt_outlined,
                                    color: Colors.white70,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${review['likes']}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.05),
                                  const Icon(
                                    Icons.comment_outlined,
                                    color: Colors.white70,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${review['comments']}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.more_vert,
                                    color: Colors.white54,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Divider(
                                thickness: 0.5,
                                color: OTTColors.preferredServices,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
