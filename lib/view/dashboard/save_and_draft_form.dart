import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_card_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_floating_action_button.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/submit_form.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custome_pop_down.dart';
import '../votar_registration_form/basic_voter_registration_form.dart';

class SaveDraftForm extends StatelessWidget {
  const SaveDraftForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
          icon: Icon(
            Icons.add,
            color: appYellowColor,
          ),
          onPressed: () => Get.to(() => const BasicVoterRegistrationForm())),
      appBar: AppBarWidget(
        actions: [
          TextButton(
              onPressed: () {},
              child: Icon(
                Icons.sync_outlined,
                color: appColor,
              )),
          const CustomPopDown()
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomSelectedButton(
                    text: "Save & Draft",
                    onPressed: () {},
                    isSelected: true,
                  ),
                  getwidth(context, 0.010),
                  CustomSelectedButton(
                    text: "Submit",
                    onPressed: () => Get.off(() => const SubmitForm(),
                        transition: Transition.native),
                    isSelected: false,
                  ),
                ],
              ),
              getheight(context, 0.020),
              CustomExpandedButton(text: "Search Keywords", onPressed: () {}),
              getheight(context, 0.020),
              CustomContainerListTile(
                  title: "Olamide Adeola (M)",
                  subtitle: "+234 803 231 5890",
                  image: const CircleAvatar(),
                  onIconPressed: () {}),
              getheight(context, 0.020),
              CustomContainerListTile(
                  title: "Babatunde (M)",
                  subtitle: "+234 803 322 3455",
                  image: const CircleAvatar(),
                  onIconPressed: () {}),
              getheight(context, 0.020),
              CustomContainerListTile(
                  title: "Yetunde Ayodele (M)",
                  subtitle: "+234 803 322 3455",
                  image: const CircleAvatar(),
                  onIconPressed: () {}),
              getheight(context, 0.020),
              CustomContainerListTile(
                  title: "Jadhesdha Lautne (M)",
                  subtitle: "+234 803 322 3455",
                  image: const CircleAvatar(),
                  onIconPressed: () {}),
              getheight(context, 0.020),
              CustomContainerListTile(
                  title: "Pehtsar Healmar (M)",
                  subtitle: "+234 803 322 3455",
                  image: const CircleAvatar(),
                  onIconPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
