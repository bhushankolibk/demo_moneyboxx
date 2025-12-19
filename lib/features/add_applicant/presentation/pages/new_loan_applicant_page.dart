import 'package:flutter/material.dart';
import 'package:moneybox_task/core/utils/utils.dart';
import 'package:moneybox_task/features/add_applicant/presentation/widgets/applicant_step.dart';
import 'package:moneybox_task/features/add_applicant/presentation/widgets/business_step.dart';
import 'package:moneybox_task/features/add_applicant/presentation/widgets/loan_step.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/loan_applicant_entity.dart';
import '../bloc/add_applicant_bloc.dart';
import '../widgets/loan_stepper.dart';
import '../widgets/review_step.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class NewLoanApplicationPage extends StatefulWidget {
  const NewLoanApplicationPage({super.key});

  @override
  State<NewLoanApplicationPage> createState() => _NewLoanApplicationPageState();
}

class _NewLoanApplicationPageState extends State<NewLoanApplicationPage> {
  late TextEditingController _businessNameCtrl;
  late TextEditingController _registrationCtrl;
  late TextEditingController _applicantNameCtrl;
  late TextEditingController _panCtrl;
  late TextEditingController _aadhaarCtrl;
  late TextEditingController _mobileCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _yearsInOperation;

  String _businessType = "Sole Proprietorship";
  double _loanAmount = 500000;
  String _tenure = "12";
  List<String> _loanPurpose = ["Working Capital"];

  @override
  void initState() {
    super.initState();
    _initControllers();

    context.read<AddApplicationBloc>().add(CheckForDraft());
  }

  void _initControllers() {
    _businessNameCtrl = TextEditingController();
    _registrationCtrl = TextEditingController();
    _applicantNameCtrl = TextEditingController();
    _panCtrl = TextEditingController();
    _aadhaarCtrl = TextEditingController();
    _mobileCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _yearsInOperation = TextEditingController(text: "0");
  }

  @override
  void dispose() {
    _businessNameCtrl.dispose();
    _registrationCtrl.dispose();
    _applicantNameCtrl.dispose();
    _panCtrl.dispose();
    _aadhaarCtrl.dispose();
    _mobileCtrl.dispose();
    _emailCtrl.dispose();
    _yearsInOperation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddApplicationBloc, AddApplicationState>(
      listener: (context, state) {
        if (!state.isLoading) {
          _syncStateWithBloc(state.applicationModel);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final currentStep = state.applicationModel.currentStep;
        final totalSteps = 4;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "New Loan Application",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColors.primary,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Column(
            children: [
              // 1. Stepper Widget
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: LoanStepper(
                  currentStep: currentStep,
                  steps: const ["Business", "Applicant", "Loan", "Review"],
                ),
              ),

              // 2. Form Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: _buildStepContent(context, currentStep, state),
                ),
              ),

              // 3. Navigation Bar
              _buildBottomBar(context, currentStep, totalSteps),
            ],
          ),
        );
      },
    );
  }

  void _syncStateWithBloc(LoanApplicationEntity data) {
    if (_businessNameCtrl.text != data.businessName) {
      _businessNameCtrl.text = data.businessName ?? "";
    }
    if (_registrationCtrl.text != data.registrationNumber) {
      _registrationCtrl.text = data.registrationNumber ?? "";
    }
    if (_yearsInOperation.text != data.yearsInOperation) {
      _yearsInOperation.text = data.yearsInOperation?.toString() ?? "";
    }
    if (_applicantNameCtrl.text != data.applicantName) {
      _applicantNameCtrl.text = data.applicantName ?? "";
    }
    if (_panCtrl.text != data.panCard) _panCtrl.text = data.panCard ?? "";
    if (_aadhaarCtrl.text != data.aadhaarNumber) {
      _aadhaarCtrl.text = data.aadhaarNumber ?? "";
    }
    if (_mobileCtrl.text != data.mobileNumber) {
      _mobileCtrl.text = data.mobileNumber ?? "";
    }
    if (_emailCtrl.text != data.emailAddress) {
      _emailCtrl.text = data.emailAddress ?? "";
    }

    // Primitives (Dropdowns, Sliders)
    if (data.businessType != null) _businessType = data.businessType!;
    if (data.yearsInOperation != null) {
      _yearsInOperation.text = data.yearsInOperation.toString();
    }
    if (data.loanAmount != null) _loanAmount = data.loanAmount!;
    if (data.tenure != null) _tenure = data.tenure!;
    if (data.loanPurpose != null && data.loanPurpose!.isNotEmpty) {
      _loanPurpose = data.loanPurpose!;
    }
  }

  void _onNext(BuildContext context, int currentStep) {
    if (currentStep == 0) {
      if (_businessNameCtrl.text.isEmpty ||
          _registrationCtrl.text.isEmpty ||
          _yearsInOperation.text.isEmpty) {
        // Show error
        Utils.showSnackBar(
          "Please fill all business details.",
          context,
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        );
        return;
      }
    } else if (currentStep == 1) {
      if (_applicantNameCtrl.text.isEmpty ||
          (_panCtrl.text.isEmpty ||
              _aadhaarCtrl.text.isEmpty ||
              _mobileCtrl.text.isEmpty ||
              _emailCtrl.text.isEmpty)) {
        Utils.showSnackBar(
          "Please fill all applicant details.",
          context,
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        );
        return;
      }
      if (!RegExp(
        r'^[A-Z]{5}[0-9]{4}[A-Z]$',
      ).hasMatch(_panCtrl.text.toUpperCase())) {
        Utils.showSnackBar(
          "Please enter a valid PAN number.",
          context,
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        );
        return;
      }

      if (!RegExp(r'^\d{4}-\d{4}-\d{4}$').hasMatch(_aadhaarCtrl.text)) {
        Utils.showSnackBar(
          "Please enter a valid Aadhaar number.",
          context,
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        );
        return;
      }
      if (!RegExp(r'^[6-9]\d{9}$').hasMatch(_mobileCtrl.text)) {
        // Indian mobile number format
        Utils.showSnackBar(
          "Please enter a valid mobile number.",
          context,
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        );
        return;
      }
      if (!RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(_emailCtrl.text)) {
        Utils.showSnackBar(
          "Please enter a valid email address.",
          context,
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        );
        return;
      }
    } else if (currentStep == 2) {
      if (_loanAmount <= 0 || _tenure.isEmpty || _loanPurpose.isEmpty) {
        // Show error
        Utils.showSnackBar(
          "Please fill all loan details.",
          context,
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        );
        return;
      }
    }
    context.read<AddApplicationBloc>().add(
      NextStepEvent(
        businessName: _businessNameCtrl.text,
        businessType: _businessType,
        registrationNumber: _registrationCtrl.text,

        yearsInOperation: _yearsInOperation.text,

        applicantName: _applicantNameCtrl.text,
        panCard: _panCtrl.text,
        aadhaarNumber: _aadhaarCtrl.text,
        mobileNumber: _mobileCtrl.text,
        emailAddress: _emailCtrl.text,

        loanAmount: _loanAmount,
        tenure: _tenure,
        loanPurpose: _loanPurpose,
      ),
    );
  }

  void _onBack(BuildContext context) {
    context.read<AddApplicationBloc>().add(PreviousStepEvent());
  }

  void _onSubmit(BuildContext context) {
    context.read<AddApplicationBloc>().add(SubmitApplicationEvent());
    Navigator.pop(context);
  }

  Widget _buildStepContent(
    BuildContext context,
    int step,
    AddApplicationState state,
  ) {
    switch (step) {
      case 0:
        return BusinessStepForm(
          nameController: _businessNameCtrl,
          initialBusinessType: _businessType,
          registrationController: _registrationCtrl,
          yearsInOperationController: _yearsInOperation,
          onTypeChanged: (val) => setState(() => _businessType = val!),
        );
      case 1:
        return ApplicantStepForm(
          nameController: _applicantNameCtrl,
          panController: _panCtrl,
          aadhaarController: _aadhaarCtrl,
          mobileController: _mobileCtrl,
          emailController: _emailCtrl,
        );
      case 2:
        return LoanStepForm(
          initialAmount: _loanAmount,
          initialTenure: _tenure,
          initialPurpose: _loanPurpose.isNotEmpty
              ? _loanPurpose.first
              : "Working Capital",
          onLoanDetailsChanged: (amount, tenure, purpose) {
            setState(() {
              _loanAmount = amount;
              _tenure = tenure;
              _loanPurpose = [purpose]; // Assuming single select for now
            });
          },
        );
      case 3:
        return ReviewStepForm(
          data: _mapModelToEntity(
            state.applicationModel,
          ), // convert model -> entity
          onEditPressed: (stepIndex) {
            // Optional: Jump to step logic
            context.read<AddApplicationBloc>().add(JumpToStepEvent(stepIndex));
          },
        );
      default:
        return const SizedBox();
    }
  }

  LoanApplicationEntity _mapModelToEntity(dynamic model) {
    return LoanApplicationEntity(
      businessName: model?.businessName,
      registrationNumber: model?.registrationNumber,
      applicantName: model?.applicantName,
      panCard: model?.panCard,
      aadhaarNumber: model?.aadhaarNumber,
      mobileNumber: model?.mobileNumber,
      emailAddress: model?.emailAddress,
      businessType: model?.businessType,
      yearsInOperation: model?.yearsInOperation,
      loanAmount: model?.loanAmount,
      tenure: model?.tenure,
      loanPurpose: model?.loanPurpose ?? [],
      currentStep: model?.currentStep ?? 0,
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    int currentStep,
    int totalSteps,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          if (currentStep > 0) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: () => _onBack(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Back",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                if (currentStep == totalSteps - 1) {
                  _onSubmit(context);
                } else {
                  _onNext(context, currentStep);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                currentStep == totalSteps - 1 ? "Submit Application" : "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
