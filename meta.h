extern int yylineno;
void yyerror(char *s, ...);

#define N 64

typedef struct {
    scalars t_scalar[N];
    size_t num_scalars;
    types t_type[N];
    size_t num_types;
    enums t_enum[N];
    size_t num_enums;
    directives t_directive[N];
    size_t num_directives;
} t_document;

typedef struct {
    name *char;
    description *char;
} t_scalar;

typedef struct {
	name *char;
	description *char;
	locations t_directive_location[N];
    size_t num_locations;
	args t_input_value[N];
    size_t num_args;
} t_directive;

typedef struct {
    kind t_typekind;
    name *char;
    description *char;
    fields t_field[N]; // object,interface
    size_t num_fields;
    //interfaces interface[N]; // not supported
    //size_t num_interfaces;
    //possibleTypes t_type[N]; // for unions
    //size_t num_possibleTypes;
    enumValues t_enum_value[N]; // enum
    size_t num_enumValues;
    inputFields t_input_value[N]; // object
    size_t num_inputFields;
    ofType t_type; // list,nonnull
} t_type;

typedef struct {
    name *char;
    description *char;
    fields t_enum_field[N];
    size_t num_fields;
} t_enum;

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

typedef struct {
	name *char;
	description *char;
    type t_type;
	defaultValue *char;
} t_input_value;

typedef enum {
    DIRECTIVE_LOCATION_QUERY,
    DIRECTIVE_LOCATION_MUTATION,
    DIRECTIVE_LOCATION_SUBSCRIPTION,
    DIRECTIVE_LOCATION_FIELD,
    DIRECTIVE_LOCATION_FRAGMENT_DEFINITION,
    DIRECTIVE_LOCATION_FRAGMENT_SPREAD,
    DIRECTIVE_LOCATION_INLINE_FRAGMENT,
    DIRECTIVE_LOCATION_SCHEMA,
    DIRECTIVE_LOCATION_SCALAR,
    DIRECTIVE_LOCATION_OBJECT,
    DIRECTIVE_LOCATION_FIELD_DEFINITION,
    DIRECTIVE_LOCATION_ARGUMENT_DEFINITION,
    DIRECTIVE_LOCATION_INTERFACE,
    DIRECTIVE_LOCATION_UNION,
    DIRECTIVE_LOCATION_ENUM,
    DIRECTIVE_LOCATION_ENUM_VALUE,
    DIRECTIVE_LOCATION_INPUT_OBJECT,
    DIRECTIVE_LOCATION_INPUT_FIELD_DEFINITION
} t_directive_location;

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

