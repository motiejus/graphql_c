extern int yylineno;
void yyerror(char *s, ...);

typedef struct {
    scalars **t_scalar;
    size_t num_scalars;
    types **t_type;
    size_t num_types;
    enums **t_enum;
    size_t num_enums;
    directives **t_directive;
    size_t num_directives;
} t_document;

typedef struct {
    name *char;
    description *char;
} t_scalar;

typedef struct {
    name *char;
    description *char;
    fields **t_enum_field;
    size_t num_fields;
} t_enum;

typedef struct {
    kind t_typekind;
    name *char;
    description *char;
    fields **t_field; // object,interface
    size_t num_fields;
    //interfaces **interface; // not supported
    //size_t num_interfaces;
    //possibleTypes **t_type; // for unions
    //size_t num_possibleTypes;
    enumValues **t_enum_value; // enum
    size_t num_enumValues;
    inputFields **t_input_value; // object
    size_t num_inputFields;
    ofType t_type; // list,nonnull
} t_type;

typedef struct {
	name *char;
	description *char;
	locations *t_directive_location;
    size_t num_locations;
	args **t_input_value;
    size_t num_args;
} t_directive;

typedef struct {
    description *char;
    name *char;
} t_enum_field;

typedef struct {
	name *char;
	description *char;
	isDeprecated *bool;
	deprecationReason *char;
} t_enum_value;

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
    type t_type;
	defaultValue *char;
} t_input_value;

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
} t_directive_location;

