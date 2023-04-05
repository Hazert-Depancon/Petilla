import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patily/product/models/patily_form/answer_form_model.dart';

class AnswerFormWidget extends StatefulWidget {
  const AnswerFormWidget({super.key, required this.answerFormModel});
  final AnswerFormModel answerFormModel;

  @override
  State<AnswerFormWidget> createState() => _AnswerFormWidgetState();
}

class _AnswerFormWidgetState extends State<AnswerFormWidget> {
  late final String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat(
      DateFormat.YEAR_MONTH_DAY,
    ).format(widget.answerFormModel.createdTime.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(widget.answerFormModel.currentUserName.characters.first),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.answerFormModel.currentUserName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  widget.answerFormModel.description,
                  overflow: TextOverflow.clip,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Text(formattedDate),
            ],
          ),
        ],
      ),
    );
  }
}
