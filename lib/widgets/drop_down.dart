import 'package:flutter/material.dart';

class DropDown<T> extends StatefulWidget {
  final T value;
  final ValueChanged<T> onChanged;
  final String hintText;
  final String labelText;
  final List<T> list;
  final FormFieldValidator<T> validator;
  final FormFieldSetter<T> onSaved;
  final Widget prefixIcon;
  final bool needSpace;

  const DropDown({
    Key key,
    this.value,
    @required this.onChanged,
    this.hintText,
    this.labelText,
    @required this.list,
    @required this.validator,
    @required this.onSaved,
    this.prefixIcon,
    this.needSpace = true,
  }) : super(key: key);

  @override
  _DropDownState<T> createState() => _DropDownState<T>();
}

class _DropDownState<T> extends State<DropDown<T>> {
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _focus?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            widget.labelText,
            style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 16),
          ),
        ),
        SizedBox(height: 6),
        DropdownButtonFormField<T>(
          value: widget.value,
          onChanged: widget.onChanged,
          hint: Text(
            widget.hintText,
            style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 16),
          ),
          focusNode: _focus,
          validator: widget.validator,
          onSaved: widget.onSaved,
          items: widget.list
              ?.map((T e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(
                    '$e',
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(fontSize: 16),
                  )))
              ?.toList(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 18,
            ),
            hintStyle:
                Theme.of(context).textTheme.headline2.copyWith(fontSize: 16),
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).backgroundColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        widget.needSpace
            ? SizedBox(
                height: 21,
              )
            : SizedBox(),
      ],
    );
  }
}
