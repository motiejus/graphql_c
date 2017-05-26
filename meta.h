extern int yylineno;
void yyerror(char* s, ...);

typedef struct {
    t_scalar* scalars;
    t_type* types;
    t_enum* enums;
    t_directive* directives;
} t_document;

typedef struct {
    char* name;
    char* description;
    t_scalar* next;
} t_scalar;

typedef struct {
    char* name;
    char* description;
    t_enum_field* fields;
    t_enum* next;
} t_enum;

typedef struct {
    t_typekind kind;
    char* name;
    char* description;
    t_field* fields; // object,interface
    //interfaces* interface; // not supported
    //possibleTypes* *t_type; // for unions
    t_enum_value* enumValues; // enum
    t_input_value* inputFields; // object
    t_type* ofType; // list,nonnull
    t_type* next;
} t_type;

typedef struct {
	char* name;
	char* description;
	t_directive_location* locations;
	t_input_value* args;
    t_directive* next;
} t_directive;

typedef struct {
    char* description;
    char* name;
    t_enum_field* next;
} t_enum_field;

typedef struct {
	char* name;
	char* description;
	boo* isDeprecated;
	char* deprecationReason;
    t_enum_value* next;
} t_enum_value;

typedef struct {
	char* name;
	char* description;
	t_input_value* args;
	t_type* type;
	bool isDeprecated;
	char* deprecationReason;
    t_field* next;
} t_field;

typedef enum {
    TYPEKIND_SCALAR,
    TYPEKIND_OBJECT,
    TYPEKIND_INTERFACE,
    TYPEKIND_UNION,
    TYPEKIND_ENUM,
    TYPEKIND_INPUT_OBJECT,
    TYPEKIND_LIST,
    TYPEKIND_NONNULL
} t_typekind;

typedef struct {
	char* name;
	char* description;
    t_type* type;
	char* defaultValue;
    t_input_value* next;
} t_input_value;

typedef struct {
    e_directive_locatio* location;
    t_directive_location* next;
} t_directive_location;

typedef enum {
    DIRLOC_QUERY,
    DIRLOC_MUTATION,
    DIRLOC_SUBSCRIPTION,
    DIRLOC_FIELD,
    DIRLOC_FRAGMENT_DEFINITION,
    DIRLOC_FRAGMENT_SPREAD,
    DIRLOC_INLINE_FRAGMENT,
    DIRLOC_SCHEMA,
    DIRLOC_SCALAR,
    DIRLOC_OBJECT,
    DIRLOC_FIELD_DEFINITION,
    DIRLOC_ARGUMENT_DEFINITION,
    DIRLOC_INTERFACE,
    DIRLOC_UNION,
    DIRLOC_ENUM,
    DIRLOC_ENUM_VALUE,
    DIRLOC_INPUT_OBJECT,
    DIRLOC_INPUT_FIELD_DEFINITION
} e_directive_location;
