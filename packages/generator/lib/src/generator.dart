// ignore_for_file: implementation_imports

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:fields/domain/class.dart';
import 'package:fields/templates/fields_template.dart';
import 'package:fields_annotation/src/fields.dart';
import 'package:source_gen/source_gen.dart';

/// {@template fields_generator}
/// A [Generator] that generates all keys for fields
/// from the [Fields] annotation
/// {@endtemplate}
class FieldsGenerator extends GeneratorForAnnotation<Fields> {
  /// {@macro fields_generator}
  const FieldsGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator cannot target `${element.runtimeType}`.',
        element: element,
      );
    }

    final buffer = StringBuffer();

    final subject = Class.fromElement(element);

    FieldsTemplate(subject).addToBuffer(buffer);

    return buffer.toString();
  }
}
