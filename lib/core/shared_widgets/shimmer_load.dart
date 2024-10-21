import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';


// Shimmer effect for MovieCard
class MovieCardShimmer extends StatelessWidget {

  const MovieCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Colors.white, // Placeholder color
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60.w,
                    height: 12.sp,
                    color: Colors.white,
                  ),
                  SizedBox(height: 0.5.h),
                  Container(
                    width: 30.w,
                    height: 8.sp,
                    color: Colors.white,
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




class MovieDetailShimmer extends StatelessWidget {
  const MovieDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.5, // Adjust as needed
            maxChildSize: 0.9,
            minChildSize: 0.4,
            builder: (context, scrollController) {
              return SingleChildScrollView( // inside single child scroll view
                controller: scrollController,
                child: Container( // Container instead of Padding
                  decoration: const BoxDecoration(
                      color: Color(0xff1C1C1C),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))

                  ),
                  padding: const EdgeInsets.all(16),

                  child: Column( // wrap content with column
                    crossAxisAlignment: CrossAxisAlignment.start, // same properties

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(height: 10.w, width: 10.w, color: Colors.white,),
                          Container(height: 10.w, width: 10.w, color: Colors.white,)
                        ],

                      ),
                      SizedBox(height: 10.h),

                      _shimmerWidget(height: 30.w, width: 30.w),
                      SizedBox(height: 2.h),

                      _shimmerWidget(height: 4.sp, width: 50.w),

                      Padding( // Keep padding but add color to container to display shimmer effect.
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(height: 2.h, width: 50.w, child: Container(color: Colors.white,),),
                      ),

                      _shimmerWidget(height: 4.sp, width: 80.w),
                      SizedBox(height: 1.h),

                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0), // add vertical padding
                          child: _shimmerWidget(width: 40.w, height: 4.sp)

                      ),
                      _shimmerWidget(width: 80.w, height: 4.sp),
                      SizedBox(height: 3.h),

                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: _shimmerWidget(width: 30.w, height: 4.sp)
                      ),

                      SizedBox(
                        height: 20.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4, // Replace with actual cast count.
                            itemBuilder: (context, index) {

                              return Padding(
                                padding: EdgeInsets.only(right: 4.w), // add padding here
                                child: Column(
                                  children: [

                                    _shimmerWidget(height: 20.sp, width: 20.sp, isCircular: true,),
                                    SizedBox(height: 1.h),

                                    _shimmerWidget(height: 2.sp, width: 20.w),

                                    _shimmerWidget(height: 2.sp, width: 15.w,),
                                  ],
                                ),
                              );

                            }
                        ),
                      ),

                      _shimmerWidget(height: 6.h, width: double.infinity), // make the shimmer fill the parent.
                    ],
                  ),
                ),

              );
            },
          ),
        ],
      ),
    );
  }


  // helper method to return a shimmer widget.
  Widget _shimmerWidget({required double width, required double height, bool isCircular = false}){
    return SizedBox(
      width: width,
      height: height,

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isCircular ? BorderRadius.circular(100) : null, // handles circular shimmer
        ),
      ),
    );

  }



}