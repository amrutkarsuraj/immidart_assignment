import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immidart_assignment/features/assignment/data/model/assignment_model.dart';
import 'package:immidart_assignment/features/assignment/data/model/country_model.dart';
import 'package:immidart_assignment/features/assignment/presentation/providers/assignment_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AssignmentFormPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsync = ref.watch(countriesProvider);
    final theme = Theme.of(context);
    var showVisa = ref.watch(showVisaProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Assignment Request'),
        centerTitle: false,
        elevation: 0,
      ),
      body: countriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Error loading countries')),
        data: (countries) {
          return Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Card(
                  elevation: 6,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Assignment Details',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),

                          _fieldLabel('Employee Name'),
                          FormBuilderTextField(
                            name: 'employeeName',
                            decoration: _inputDecoration('Enter employee name'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),

                          const SizedBox(height: 16),

                          _fieldLabel('Destination Country'),
                          FormBuilderDropdown<CountryModel>(
                            name: 'country',
                            decoration:
                            _inputDecoration('Select destination'),
                            items: countries
                                .map(
                                  (c) => DropdownMenuItem(
                                value: c,
                                child: Text(c.name),
                              ),
                            )
                                .toList(),
                            onChanged: (value) {
                              showVisa =
                                  value?.isInternational ?? false;
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),

                          const SizedBox(height: 16),

                          _fieldLabel('Start Date'),
                          FormBuilderDateTimePicker(
                            name: 'startDate',
                            inputType: InputType.date,
                            decoration:
                            _inputDecoration('Choose start date'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),

                          if (showVisa) ...[
                            const SizedBox(height: 16),
                            _fieldLabel('Visa Type'),
                            FormBuilderTextField(
                              name: 'visaType',
                              decoration:
                              _inputDecoration('Enter visa type'),
                              validator:
                              FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                          ],

                          const SizedBox(height: 28),

                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  final data = _formKey.currentState!.value;

                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Assignment Summary'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _summaryRow('Employee Name', data['employeeName']),
                                          _summaryRow('Country', data['country'].name),
                                          _summaryRow(
                                            'Start Date',
                                            data['startDate'].toString().split(' ').first,
                                          ),
                                          if (data['visaType'] != null)
                                            _summaryRow('Visa Type', data['visaType']),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);

                                            ref
                                                .read(assignmentSubmitProvider.notifier)
                                                .submit(
                                              AssignmentModel(
                                                employeeName: data['employeeName'],
                                                country: data['country'].name,
                                                startDate: data['startDate'].toString(),
                                                visaType: data['visaType'],
                                              ),
                                            );

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Assignment submitted successfully'),
                                              ),
                                            );
                                          },
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },

                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text('$label: $value'),
    );
  }


}
