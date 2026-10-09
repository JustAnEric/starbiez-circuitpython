// modjerryscript.c
#include "py/runtime.h"
#include "py/obj.h"
#include "py/mperrno.h"
#include "jerryscript.h"

#ifndef STATIC
#define STATIC static
#endif

STATIC mp_obj_t jerryscript_init(void) {
    jerry_init(JERRY_INIT_EMPTY);
    return mp_const_none;
}
STATIC MP_DEFINE_CONST_FUN_OBJ_0(jerryscript_init_obj, jerryscript_init);

STATIC mp_obj_t jerryscript_eval(mp_obj_t code_obj) {
    const char *code = mp_obj_str_get_str(code_obj);
    size_t code_len = strlen(code);

    jerry_value_t eval_ret = jerry_eval((const jerry_char_t *)code, code_len, JERRY_PARSE_NO_OPTS);

    if (jerry_value_is_exception(eval_ret)) {
        jerry_value_free(eval_ret);
        mp_raise_ValueError(MP_ERROR_TEXT("jerryscript execution error!"));
    }

    jerry_value_t str_val = jerry_value_to_string(eval_ret);
    jerry_size_t str_size = jerry_string_size(str_val, JERRY_ENCODING_UTF8);
    
    vstr_t vstr;
    vstr_init_len(&vstr, str_size);
    jerry_string_to_buffer(str_val, JERRY_ENCODING_UTF8, (jerry_char_t *)vstr.buf, str_size);

    jerry_value_free(str_val);
    jerry_value_free(eval_ret);

    return mp_obj_new_str_from_vstr(&vstr);
}
STATIC MP_DEFINE_CONST_FUN_OBJ_1(jerryscript_eval_obj, jerryscript_eval);

STATIC const mp_rom_map_elem_t jerryscript_module_globals_table[] = {
    { MP_ROM_QSTR(MP_QSTR___name__), MP_ROM_QSTR(MP_QSTR_jerryscript) },
    { MP_ROM_QSTR(MP_QSTR_init), MP_ROM_PTR(&jerryscript_init_obj) },
    { MP_ROM_QSTR(MP_QSTR_eval), MP_ROM_PTR(&jerryscript_eval_obj) },
};
STATIC MP_DEFINE_CONST_DICT(jerryscript_module_globals, jerryscript_module_globals_table);

const mp_obj_module_t jerryscript_cmodule = {
    .base = { &mp_type_module },
    .globals = (mp_obj_dict_t *)&jerryscript_module_globals,
};

MP_REGISTER_MODULE(MP_QSTR_jerryscript, jerryscript_cmodule);