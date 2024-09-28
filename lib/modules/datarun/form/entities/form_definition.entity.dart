import 'dart:convert';

import 'package:d2_remote/core/annotations/column.annotation.dart';
import 'package:d2_remote/core/annotations/entity.annotation.dart';
import 'package:d2_remote/core/annotations/reflectable.annotation.dart';
import 'package:d2_remote/core/annotations/relation.annotation.dart';
import 'package:d2_remote/modules/datarun/form/entities/dynamic_form.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/dynamic_form_field.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/option_set.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/parsing_helpers.dart';
import 'package:d2_remote/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'formTemplateV', apiResourceName: 'formVersions')
class FormTemplateV extends IdentifiableEntity {
  @ManyToOne(table: FormTemplate, joinColumnName: 'formTemplate')
  dynamic formTemplate;

  @Column(nullable: true, type: ColumnType.TEXT)
  List<FieldTemplate> fields = [];

  @Column(nullable: true, type: ColumnType.TEXT)
  List<FormOption> options = [];

  @Column(nullable: true, type: ColumnType.TEXT)
  List<DOptionSet> optionSets = [];

  @Column(nullable: false, type: ColumnType.TEXT)
  Map<String, String> label = {};

  @Column(nullable: false, type: ColumnType.TEXT)
  String defaultLocal;

  @Column(nullable: false)
  String activity;

  @Column(nullable: false, type: ColumnType.INTEGER)
  int version;

  @Column(nullable: true, type: ColumnType.TEXT)
  List<String> orgUnits = [];

  FormTemplateV({
    String? id,
    String? uid,
    String? name,
    String? code,
    String? createdDate,
    String? lastModifiedDate,
    required this.activity,
    this.formTemplate,
    required this.version,
    required this.defaultLocal,
    List<FieldTemplate> fields = const [],
    List<FormOption> options = const [],
    List<DOptionSet> optionSets = const [],
    Map<String, String> label = const {},
    List<String> orgUnits = const [],
    required dirty,
  }) : super(
          id: id,
          uid: uid,
          name: name,
          code: code,
          createdDate: createdDate,
          lastModifiedDate: lastModifiedDate,
          dirty: dirty,
        ) {
    this.fields.addAll(fields);
    this.options.addAll(options);
    this.optionSets.addAll(optionSets);
    this.label.addAll(label);
    this.orgUnits.addAll(orgUnits);
  }

  factory FormTemplateV.fromJson(Map<String, dynamic> json) {
    final orgUnits = json['orgUnits'] != null
        ? json['orgUnits'].runtimeType == String
            ? jsonDecode(json['orgUnits']).cast<String>()
            : json['orgUnits'].cast<String>()
        : <String>[];

    final fields = json['fields'] != null
        ? (parseDynamicJson(json['fields']) as List)
            .map((field) => FieldTemplate.fromJson(field))
            .toList()
        : <FieldTemplate>[];

    final options = json['options'] != null
        ? (parseDynamicJson(json['options']) as List)
            .map((option) => FormOption.fromJson(option))
            .toList()
        : <FormOption>[];

    final optionSets = json['optionSets'] != null
        ? (parseDynamicJson(json['optionSets']) as List)
            .map((optionSet) => DOptionSet.fromJson(optionSet))
            .toList()
        : <DOptionSet>[];

    return FormTemplateV(
      id: json['id'],
      uid: json['uid'],
      code: json['code'],
      name: json['name'],
      activity: json['activity'],
      version: json['version'],
      formTemplate: json['formTemplate'],
      label: json['label'] != null
          ? Map<String, String>.from(json['label'] is String
              ? jsonDecode(json['label'])
              : json['label'])
          : {"en": json['name']},
      defaultLocal: json['defaultLocal'] ?? 'en',
      fields: fields,
      options: options,
      optionSets: optionSets,
      orgUnits: orgUnits,
      createdDate: json['createdDate'],
      lastModifiedDate: json['lastModifiedDate'],
      dirty: json['dirty'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'code': code,
      'name': name,
      'activity': activity,
      'version': version,
      'formTemplate': formTemplate,
      'label': jsonEncode(label),
      'defaultLocal': defaultLocal,
      'orgUnits': jsonEncode(orgUnits),
      'fields': jsonEncode(fields.map((field) => field.toJson()).toList()),
      'options': jsonEncode(options.map((option) => option.toJson()).toList()),
      'optionSets': jsonEncode(
          optionSets.map((optionSet) => optionSet.toJson()).toList()),
      'createdDate': createdDate,
      'lastModifiedDate': lastModifiedDate,
      'dirty': dirty,
    };
  }
}
