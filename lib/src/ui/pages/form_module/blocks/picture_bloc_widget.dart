import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../styles/my_button_styles.dart';
import '../../../utils/constants.dart';
import 'block_title_widget.dart';

class PictureBlockWidget extends StatefulWidget {
  final String title;
  final String description;
  final int? maxLines;
  final TextInputType? textInputType;
  final Function(String) callback;

  const PictureBlockWidget({super.key, required this.title, required this.description, this.maxLines = 1, this.textInputType = TextInputType.text, required this.callback});

  @override
  State<PictureBlockWidget> createState() => _PictureBlockWidgetState();
}

class _PictureBlockWidgetState extends State<PictureBlockWidget> {
  String? _imagePath;
  String _buttonText = 'Tomar foto';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlockTitleWidget(
            title: widget.title,
            description: widget.description,
          ),
          Column(
            children: [
              if (_imagePath != null) ...[
                _image(),
                const SizedBox(height: 16.0),
              ],
              _takePictureButton()
            ],
          )
        ],
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _takePictureButton() {
    return ElevatedButton(
      onPressed: () => _getImage(),
      style: MyButtonStyles.secondaryButton,
      child: Text(_buttonText, style: const TextStyle(color: Constants.whiteLabelTextColor))
    );
  }

  Widget _image() {
    return SizedBox(
      height: 214,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: _imagePath != null ? Image.file(File(_imagePath!)) : Container()
          ),
          _deleteButton()
        ],
      ),
    );
  }

  Widget _deleteButton() {
    return Positioned(
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0)
        ),
        child: IconButton(
          onPressed: () => setState(() {
            _imagePath = null;
            _buttonText = 'Tomar foto';
          }),
          icon: const Icon(Icons.delete_outline, size: 30),
        ),
      ),
    );
  }

  /*
   * METHODS
   */
  void _getImage() async {
    var picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      setState(() { 
        _imagePath = image.path;
        _buttonText = 'Tomar otra foto';
      });
      widget.callback(_imagePath!);
    }
  }
}