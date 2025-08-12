import 'package:flutter_demo/app/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RFXTextFormField extends StatefulWidget {
  const RFXTextFormField({
    super.key,
    required this.labelText,
    this.autoFocus,
    this.initialValue,
    this.controller,
    this.maxLength,
    this.enabled = true,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.readOnly = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.hintText,
    this.errorText,
    this.descriptionText,
    this.showCounter = false,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String labelText;

  final bool? autoFocus;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final String? initialValue;

  final TextInputType? keyboardType;

  final TextCapitalization textCapitalization;

  final TextInputAction? textInputAction;

  final bool enabled;

  final TextAlign textAlign;

  final TextAlignVertical? textAlignVertical;

  final bool readOnly;

  final bool obscureText;

  final bool autocorrect;

  final MaxLengthEnforcement? maxLengthEnforcement;

  final int? maxLines;

  final int? minLines;

  final int? maxLength;

  final bool expands;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onFieldSubmitted;

  final VoidCallback? onTap;

  final String? hintText;

  final String? errorText;

  final String? descriptionText;

  final bool showCounter;

  final String? Function(String?)? validator;

  final List<TextInputFormatter>? inputFormatters;

  final Widget? prefixIcon;

  final Widget? suffixIcon;

  @override
  State<RFXTextFormField> createState() => _RFXTextFormFieldState();
}

class _RFXTextFormFieldState extends State<RFXTextFormField> {
  /// Tracks remaining characters when maxLength is set
  int remainingCharacters = 0;

  late TextEditingController _innerController;

  @override
  void initState() {
    super.initState();

    _innerController = widget.controller ?? TextEditingController();

    if (widget.initialValue != null) {
      _innerController.text = widget.initialValue!;
    }

    remainingCharacters =
        (widget.maxLength ?? 0) - _innerController.text.length;
    _innerController.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant RFXTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // handle controller changes
    if (widget.controller != null &&
        widget.controller != oldWidget.controller) {
      _innerController.removeListener(_onTextChanged);
      _innerController = widget.controller!;
      _innerController.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    // clean up controller
    if (widget.controller != _innerController) {
      _innerController
        ..removeListener(_onTextChanged)
        ..dispose();
    }

    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {
        remainingCharacters =
            (widget.maxLength ?? 0) - _innerController.text.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final disabledColor = theme.hintColor;
    final normalColor = theme.colorScheme.onSurface;
    final focusedColor = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText.isNotEmpty)
          Text(
            widget.labelText,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: widget.enabled ? normalColor : disabledColor,
            ),
          ),
        TextFormField(
          autofocus: widget.autoFocus ?? false,
          controller: _innerController,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          enabled: widget.enabled,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          readOnly: widget.readOnly,
          obscureText: widget.obscureText,
          autocorrect: widget.autocorrect,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          maxLines: widget.maxLines,
          expands: widget.expands,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: widget.onTap,
          validator: widget.validator,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: widget.enabled ? normalColor : disabledColor,
          ),
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: normalColor, width: 2),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: normalColor, width: 2),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: disabledColor, width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: focusedColor, width: 2),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
            ),
            enabled: widget.enabled,
            hintText: widget.hintText,
            hintStyle: theme.textTheme.bodyLarge,
            contentPadding: const EdgeInsets.symmetric(
              vertical: RFXSpacing.spacing12,
            ),
            counterText: '',
            error: widget.errorText != null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(top: RFXSpacing.medium),
                    child: Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.info,
                            color: theme.colorScheme.errorContainer,
                          ),
                        ),
                        const SizedBox(width: RFXSpacing.small),
                        Expanded(
                          child: Text(
                            widget.errorText!,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onErrorContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: const BoxConstraints(
              maxWidth: 32,
              maxHeight: 32,
            ),
            suffixIcon: widget.suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              maxWidth: 32,
              maxHeight: 32,
            ),
          ),
        ),
        if (widget.showCounter && widget.maxLength != null)
          Padding(
            padding: const EdgeInsets.only(top: RFXSpacing.medium),
            child: Text(
              remainingCharacters > 1
                  ? '$remainingCharacters characters left'
                  : '$remainingCharacters character left',
              style: theme.textTheme.labelMedium?.copyWith(
                color: widget.enabled ? normalColor : disabledColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (widget.descriptionText != null)
          Padding(
            padding: const EdgeInsets.only(top: RFXSpacing.medium),
            child: Text(
              widget.descriptionText!,
              style: theme.textTheme.labelMedium?.copyWith(
                color: widget.enabled ? normalColor : disabledColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
