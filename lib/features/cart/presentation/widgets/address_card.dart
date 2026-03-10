import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/app_colors.dart';
import '../../../../route/app_routes.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is OtpValidationSuccess) {
          final address =
              "${state.userMOdel.address} ${state.userMOdel.landmark} ${state.userMOdel.pincode}";
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.boxShadowPink,
                      blurRadius: 10,
                      spreadRadius: -4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined, color: AppColors.secText),
                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                state.userMOdel.address != null
                                    ? "Delivery / Pickup Address"
                                    : "Complete Profile",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const Spacer(),

                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.profile,
                                  );
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: AppColors.secText,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Text(
                            state.userMOdel.address != null
                                ? address
                                : "Please update your profile first..",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return SliverToBoxAdapter();
      },
    );
  }
}
