import 'package:d2_remote/core/annotations/index.dart';
import 'package:d2_remote/modules/metadata/program/entities/program_rule.entity.dart';
import 'package:d2_remote/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'programruleaction', apiResourceName: 'programRuleActions')
class ProgramRuleAction extends IdentifiableEntity {
  @Column(nullable: true)
  String? content;

  @Column(nullable: true)
  String? data;

  @Column(nullable: true)
  String? displayContent;

  @Column(type: ColumnType.TEXT)
  dynamic programRuleActionType;

  @Column(nullable: true)
  String? evaluationTime;

  @Column(nullable: true)
  String? description;

  @Column(nullable: true)
  String? dataElement;

  @Column(nullable: true)
  String? trackedEntityAttribute;

  @ManyToOne(table: ProgramRule, joinColumnName: 'programRule')
  dynamic programRule;

  ProgramRuleAction(
      {String? id,
      String? name,
      this.description,
      this.content,
      this.displayContent,
      required this.programRuleActionType,
      this.evaluationTime,
      this.programRule,
      this.dataElement,
      this.trackedEntityAttribute,
      this.data,
      required bool dirty})
      : super(uid: id, name: name, dirty: dirty);

  factory ProgramRuleAction.fromJson(Map<String, dynamic> json) {
    return ProgramRuleAction(
        id: json['id'],
        name: json['name'] ?? json['id'],
        description: json['description'],
        content: json['content'],
        displayContent: json['displayContent'],
        programRuleActionType: json['programRuleActionType'],
        programRule: json['programRule'],
        dataElement: json['dataElement'] != null
            ? json['dataElement'] is String
                ? json['dataElement']
                : json['dataElement']['id']
            : null,
        trackedEntityAttribute: json['trackedEntityAttribute'] != null
            ? json['trackedEntityAttribute'] is String
                ? json['trackedEntityAttribute']
                : json['trackedEntityAttribute']['id']
            : null,
        evaluationTime: json['evaluationTime'],
        dirty: json['dirty'],
        data: json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['content'] = this.content;
    data['displayContent'] = this.displayContent;
    data['programRule'] = this.programRule;
    data['programRuleActionType'] = this.programRuleActionType;
    data['evaluationTime'] = this.evaluationTime;
    data['dataElement'] = this.dataElement;
    data['trackedEntityAttribute'] = this.trackedEntityAttribute;
    data['dirty'] = this.dirty;
    data['data'] = this.data;
    return data;
  }
}
