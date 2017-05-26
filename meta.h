extern int yylineno;
void yyerror(char *s, ...);

typedef struct {
    scalars *t_scalar;
    types *t_type;
    enums *t_enum;
    directives *t_directive;
} t_document;

typedef struct {
    name *char;
    description *char;
    next *t_scalar;
} t_scalar;

typedef struct {
    name *char;
    description *char;
    fields *t_enum_field;
    next *t_enum;
} t_enum;

typedef struct {
    kind t_typekind;
    name *char;
    description *char;
    fields *t_field; // object,interface
    //interfaces *interface; // not supported
    //possibleTypes *t_type; // for unions
    enumValues *t_enum_value; // enum
    inputFields *t_input_value; // object
    ofType *t_type; // list,nonnull
    next *t_type;
} t_type;

typedef struct {
	name *char;
	description *char;
	locations *t_directive_location;
	args *t_input_value;
    next *t_directive;
} t_directive;

typedef struct {
    description *char;
    name *char;
    next *t_enum_field;
} t_enum_field;

typedef struct {
	name *char;
	description *char;
	isDeprecated bool;
	deprecationReason *char;
    next *t_enum_value;
} t_enum_value;

typedef struct {
	name *char;
	description *char;
	args *t_input_value;
	type *t_type;
	isDeprecated bool;
	deprecationReason *char;
    next *t_field;
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
	name *char;
	description *char;
    type *t_type;
	defaultValue *char;
    next *t_input_value;
} t_input_value;

typedef struct {
    location e_directive_location;
    next *t_directive_location;
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
