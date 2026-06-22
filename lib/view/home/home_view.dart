import 'package:enquiry_hub/view_models/controller/ahec_controller.dart';
import 'package:enquiry_hub/view_models/controller/ahit_controller.dart';
import 'package:enquiry_hub/view_models/controller/tour_monks_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../res/color/app_color.dart';
import '../../res/components/venture_card.dart';
import '../../res/components/filter_chip_widget.dart';
import '../../res/components/enquiry_data_card.dart';
import '../../res/assets/images_assets.dart';
import '../../view_models/controller/home_controller.dart';
import '../../view_models/controller/bbsmit_controller.dart';
import '../../res/routes/routes_names.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController = Get.put(HomeController());
  final ahecController = Get.put(AhecController());
  final ahitController = Get.put(AhitController());
  final bbsmitController = Get.put(BbsmitController());
  final tourController = Get.put(TourMonksController());

  @override
  void initState() {
    super.initState();
    // Load initial data for the default selected venture (AHEC) after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadVentureData(homeController.selectedVentureIndex.value);
    });
  }

  void _loadVentureData(int index) {
    switch (index) {
      case 0:
        ahecController.refreshAllData();
        break;
      case 1:
        ahitController.refreshAllData();
        break;
      case 2:
        bbsmitController.refreshAllData();
        break;
      case 3:
        tourController.refreshAllData();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> ventures = [
      {
        'name': 'AHEC',
        'color': AppColor.ventureAColor,
        'logo': ImageAssets.ahecLogo,
      },
      {
        'name': 'AHIT',
        'color': AppColor.ventureBColor,
        'logo': ImageAssets.ahitLogo,
      },
      {
        'name': 'BBSMIT',
        'color': AppColor.ventureCColor,
        'logo': ImageAssets.bbsmitLogo,
      },
      {
        'name': 'TOUR MONKS',
        'color': AppColor.ventureDColor,
        'logo': ImageAssets.tourMonksLogo,
      },
    ];

    return Scaffold(
      backgroundColor: AppColor.kColorBackground,
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'all_ventures'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.kColorTextPrimary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Horizontal Ventures List
            SizedBox(
              height: 130,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: ventures.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    bool isSelected =
                        homeController.selectedVentureIndex.value == index;
                    return VentureCard(
                      name: ventures[index]['name'],
                      color: ventures[index]['color'],
                      logo: ventures[index]['logo'],
                      isSelected: isSelected,
                      onTap: () {
                        if (homeController.selectedVentureIndex.value != index) {
                          homeController.selectedVentureIndex.value = index;
                          _loadVentureData(index);
                        }
                      },
                    );
                  });
                },
              ),
            ),
            const SizedBox(height: 16),

            // Dynamic Filters based on selected venture
            if (homeController.selectedVentureIndex.value == 0) // AHEC
              SizedBox(
                height: 50,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: ahecController.filters.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => FilterChipWidget(
                        title: ahecController.filters[index],
                        isSelected:
                            ahecController.selectedFilterIndex.value == index,
                        onTap: () => ahecController.setFilterIndex(index),
                      ),
                    );
                  },
                ),
              )
            else if (homeController.selectedVentureIndex.value == 1) // AHIT
              SizedBox(
                height: 50,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: ahitController.filters.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => FilterChipWidget(
                        title: ahitController.filters[index],
                        isSelected:
                            ahitController.selectedFilterIndex.value == index,
                        onTap: () => ahitController.setFilterIndex(index),
                      ),
                    );
                  },
                ),
              )
            else if (homeController.selectedVentureIndex.value == 2) // BBSMIT
              SizedBox(
                height: 50,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: bbsmitController.filters.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => FilterChipWidget(
                        title: bbsmitController.filters[index],
                        isSelected:
                            bbsmitController.selectedFilterIndex.value == index,
                        onTap: () => bbsmitController.setFilterIndex(index),
                      ),
                    );
                  },
                ),
              )
            else if (homeController.selectedVentureIndex.value ==
                3) // TOUR MONKS
              SizedBox(
                height: 50,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: tourController.filters.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => FilterChipWidget(
                        title: tourController.filters[index],
                        isSelected:
                            tourController.selectedFilterIndex.value == index,
                        onTap: () => tourController.setFilterIndex(index),
                      ),
                    );
                  },
                ),
              )
            else
              // Default Filters for other ventures
              SizedBox(
                height: 50,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.filters.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => FilterChipWidget(
                        title: homeController.filters[index].tr,
                        isSelected:
                            homeController.selectedFilterIndex.value == index,
                        onTap: () => homeController.setFilterIndex(index),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 16),

            // Data List
            Expanded(
              child: Obx(() {
                if (homeController.selectedVentureIndex.value == 0) {
                  // AHEC Data
                  if (ahecController.isLoading.value && ahecController.ahecQueries.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final index = ahecController.selectedFilterIndex.value;
                  switch (index) {
                    case 0:
                      return _buildAhecQueryList(ahecController);
                    case 1:
                      return _buildAhecRegistrationList(ahecController);
                    case 2:
                      return _buildAhecFlRegistrationList(ahecController);
                    case 3:
                      return _buildAhecAffiliateList(ahecController);
                    case 4:
                      return _buildAhecNewsletterList(ahecController);
                    default:
                      return const Center(child: Text('No Data'));
                  }
                } else if (homeController.selectedVentureIndex.value == 1) {
                  // AHIT Data
                  if (ahitController.isLoading.value && ahitController.ahitContacts.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final index = ahitController.selectedFilterIndex.value;
                  switch (index) {
                    case 0:
                      return _buildAhitContactList(ahitController);
                    case 1:
                      return _buildAhitQuotationList(ahitController);
                    case 2:
                      return _buildAhitHireList(ahitController);
                    case 3:
                      return _buildAhitAnalysisList(ahitController);
                    default:
                      return const Center(child: Text('No Data'));
                  }
                } else if (homeController.selectedVentureIndex.value == 2) {
                  // BBSMIT Data
                  if (bbsmitController.isLoading.value && bbsmitController.bbsmitContacts.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final index = bbsmitController.selectedFilterIndex.value;
                  switch (index) {
                    case 0:
                      return _buildContactList(bbsmitController);
                    case 1:
                      return _buildEnquiryList(bbsmitController);
                    case 2:
                      return _buildRscitList(bbsmitController);
                    case 3:
                      return _buildEnrollmentList(bbsmitController);
                    case 4:
                      return _buildFacultyList(bbsmitController);
                    case 5:
                      return _buildUniversityList(bbsmitController);
                    default:
                      return const Center(child: Text('No Data'));
                  }
                } else if (homeController.selectedVentureIndex.value == 3) {
                  // TOUR MONKS Data
                  if (tourController.isLoading.value && tourController.tourContacts.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final index = tourController.selectedFilterIndex.value;
                  switch (index) {
                    case 0:
                      return _buildTourContactList(tourController);
                    case 1:
                      return _buildTourCustomizeList(tourController);
                    case 2:
                      return _buildTourBookList(tourController);
                    case 3:
                      return _buildTourEnquiryList(tourController);
                    case 4:
                      return _buildTourConfirmList(tourController);
                    default:
                      return const Center(child: Text('No Data'));
                  }
                } else {
                  return const Center(
                    child: Text('Data for other ventures will appear here'),
                  );
                }
              }),
            ),
          ],
        );
      }),
    );
  }

  // AHEC List Builders
  Widget _buildAhecQueryList(AhecController controller) {
    if (controller.ahecQueries.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No AHEC Queries Found'));
    }
    return ListView.builder(
      controller: controller.scrollController,
      itemCount:
          controller.ahecQueries.length +
          (controller.isMoreLoading.value ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == controller.ahecQueries.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final item = controller.ahecQueries[index];
        return EnquiryDataCard(
          title: item.fullName,
          subtitle: item.enService ?? item.enEmail ?? 'Query',
          date: item.enCreatedAt ?? 'N/A',
          onTap: () => Get.toNamed(
            RouteName.ahecDetailView,
            arguments: {'type': 'Queries', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildAhecRegistrationList(AhecController controller) {
    if (controller.ahecRegistrations.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No AHEC Registrations Found'));
    }
    return ListView.builder(
      controller: controller.scrollController,
      itemCount:
          controller.ahecRegistrations.length +
          (controller.isMoreLoading.value ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == controller.ahecRegistrations.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final item = controller.ahecRegistrations[index];
        return EnquiryDataCard(
          title: item.userName ?? 'User',
          subtitle: item.userEmail ?? 'No Email',
          date: item.userCreatedAt ?? 'N/A',
          onTap: () => Get.toNamed(
            RouteName.ahecDetailView,
            arguments: {'type': 'Registration', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildAhecFlRegistrationList(AhecController controller) {
    if (controller.ahecFlRegistrations.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No FL Registrations Found'));
    }
    return ListView.builder(
      controller: controller.scrollController,
      itemCount:
          controller.ahecFlRegistrations.length +
          (controller.isMoreLoading.value ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == controller.ahecFlRegistrations.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final item = controller.ahecFlRegistrations[index];
        return EnquiryDataCard(
          title: item.afName ?? 'Freelancer',
          subtitle: item.afEmail ?? 'FL Registration',
          date: item.afCrateedAt ?? 'N/A',
          onTap: () => Get.toNamed(
            RouteName.ahecDetailView,
            arguments: {'type': 'FL Registration', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildAhecAffiliateList(AhecController controller) {
    if (controller.ahecAffiliates.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Affiliate Requests Found'));
    }
    return ListView.builder(
      controller: controller.scrollController,
      itemCount:
          controller.ahecAffiliates.length +
          (controller.isMoreLoading.value ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == controller.ahecAffiliates.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final item = controller.ahecAffiliates[index];
        return EnquiryDataCard(
          title: item.afName ?? 'Affiliate',
          subtitle: item.afEmail ?? 'No Email',
          date: item.afCrateedAt ?? 'N/A',
          onTap: () => Get.toNamed(
            RouteName.ahecDetailView,
            arguments: {'type': 'Affiliate', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildAhecNewsletterList(AhecController controller) {
    if (controller.ahecNewsletters.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Newsletter Subscriptions Found'));
    }
    return ListView.builder(
      controller: controller.scrollController,
      itemCount:
          controller.ahecNewsletters.length +
          (controller.isMoreLoading.value ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == controller.ahecNewsletters.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final item = controller.ahecNewsletters[index];
        return EnquiryDataCard(
          title: item.qEmail ?? 'Newsletter Sub',
          subtitle: item.qName ?? 'Subscription',
          date: item.createdAt ?? 'N/A',
          onTap: () => Get.toNamed(
            RouteName.ahecDetailView,
            arguments: {'type': 'Newsletter', 'data': item},
          ),
        );
      },
    );
  }

  // TOUR MONKS List Builders
  Widget _buildTourContactList(TourMonksController controller) {
    if (controller.tourContacts.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Tour Contacts Found'));
    }
    return ListView.builder(
      itemCount: controller.tourContacts.length,
      itemBuilder: (context, index) {
        final item = controller.tourContacts[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.destination ?? item.email,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.tourDetailView,
            arguments: {'type': 'Contact', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildTourCustomizeList(TourMonksController controller) {
    if (controller.tourCustomizes.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Customize Requests Found'));
    }
    return ListView.builder(
      itemCount: controller.tourCustomizes.length,
      itemBuilder: (context, index) {
        final item = controller.tourCustomizes[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: 'Destination: ${item.destination}',
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.tourDetailView,
            arguments: {'type': 'Customize', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildTourBookList(TourMonksController controller) {
    if (controller.tourBooks.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Booking Requests Found'));
    }
    return ListView.builder(
      itemCount: controller.tourBooks.length,
      itemBuilder: (context, index) {
        final item = controller.tourBooks[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.tourName ?? 'Booking Request',
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.tourDetailView,
            arguments: {'type': 'Book', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildTourEnquiryList(TourMonksController controller) {
    if (controller.tourEnquiries.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Tour Enquiries Found'));
    }
    return ListView.builder(
      itemCount: controller.tourEnquiries.length,
      itemBuilder: (context, index) {
        final item = controller.tourEnquiries[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.tourName ?? 'Tour Enquiry',
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.tourDetailView,
            arguments: {'type': 'Enquiry', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildTourConfirmList(TourMonksController controller) {
    if (controller.tourBookingConfirms.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Confirmations Found'));
    }
    return ListView.builder(
      itemCount: controller.tourBookingConfirms.length,
      itemBuilder: (context, index) {
        final item = controller.tourBookingConfirms[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.tourPlanName ?? 'Booking Confirmed',
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.tourDetailView,
            arguments: {'type': 'Confirm', 'data': item},
          ),
        );
      },
    );
  }

  // AHIT List Builders
  Widget _buildAhitContactList(AhitController controller) {
    if (controller.ahitContacts.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No AHIT Contacts Found'));
    }
    return ListView.builder(
      itemCount: controller.ahitContacts.length,
      itemBuilder: (context, index) {
        final item = controller.ahitContacts[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.email,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.ahitDetailView,
            arguments: {'type': 'Contact', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildAhitQuotationList(AhitController controller) {
    if (controller.ahitQuotations.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No AHIT Quotations Found'));
    }
    return ListView.builder(
      itemCount: controller.ahitQuotations.length,
      itemBuilder: (context, index) {
        final item = controller.ahitQuotations[index];
        return EnquiryDataCard(
          title: '${item.fname} ${item.lname}',
          subtitle: item.mainservice,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.ahitDetailView,
            arguments: {'type': 'Quotation', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildAhitHireList(AhitController controller) {
    if (controller.ahitHires.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No AHIT Hire Requests Found'));
    }
    return ListView.builder(
      itemCount: controller.ahitHires.length,
      itemBuilder: (context, index) {
        final item = controller.ahitHires[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.email,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.ahitDetailView,
            arguments: {'type': 'Hire', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildAhitAnalysisList(AhitController controller) {
    if (controller.ahitAnalysis.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No AHIT Analysis Found'));
    }
    return ListView.builder(
      itemCount: controller.ahitAnalysis.length,
      itemBuilder: (context, index) {
        final item = controller.ahitAnalysis[index];
        return EnquiryDataCard(
          title: item.username,
          subtitle: item.website,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.ahitDetailView,
            arguments: {'type': 'Analysis', 'data': item},
          ),
        );
      },
    );
  }

  // BBSMIT List Builders
  Widget _buildContactList(BbsmitController controller) {
    if (controller.bbsmitContacts.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Contacts Found'));
    }
    return ListView.builder(
      itemCount: controller.bbsmitContacts.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitContacts[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.subject,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'Contact', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildEnquiryList(BbsmitController controller) {
    if (controller.bbsmitEnquiries.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Enquiries Found'));
    }
    return ListView.builder(
      itemCount: controller.bbsmitEnquiries.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitEnquiries[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.subject,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'Enquiry', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildRscitList(BbsmitController controller) {
    if (controller.bbsmitRscits.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No RSCIT Data Found'));
    }
    return ListView.builder(
      itemCount: controller.bbsmitRscits.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitRscits[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.message,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'RSCIT', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildEnrollmentList(BbsmitController controller) {
    if (controller.bbsmitEnrollments.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Enrollments Found'));
    }
    return ListView.builder(
      itemCount: controller.bbsmitEnrollments.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitEnrollments[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.subject,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'Enrollment', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildFacultyList(BbsmitController controller) {
    if (controller.bbsmitFaculties.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No Faculty Found'));
    }
    return ListView.builder(
      itemCount: controller.bbsmitFaculties.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitFaculties[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.jobRole,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'Faculty', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildUniversityList(BbsmitController controller) {
    if (controller.bbsmitUniversities.isEmpty && !controller.isLoading.value) {
      return const Center(child: Text('No University Data Found'));
    }
    return ListView.builder(
      itemCount: controller.bbsmitUniversities.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitUniversities[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: '${item.course} - ${item.university}',
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'University', 'data': item},
          ),
        );
      },
    );
  }
}
