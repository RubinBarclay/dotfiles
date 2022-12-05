#include QMK_KEYBOARD_H

enum layer_names {
    _COLMAK,
    _LOWER,
    _RAISE,
    _ADJUST
};

enum custom_keycodes {
    COLMAK = SAFE_RANGE,
    LOWER,
    RAISE,
    ADJUST
};

#define CTL_TAB CTL_T(KC_TAB)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_COLMAK] = LAYOUT_split_3x7_4(
        KC_ESC , KC_Q   , KC_W   , KC_F   , KC_P   , KC_B   , KC_LPRN,    _______, KC_J   , KC_L   , KC_U   , KC_Y   , KC_SCLN, KC_DEL ,
        CTL_TAB, KC_A   , KC_R   , KC_S   , KC_T   , KC_G   , KC_LBRC,    KC_RBRC, KC_M   , KC_N   , KC_E   , KC_I   , KC_O   , KC_BSPC,
        KC_LSFT, KC_Z   , KC_X   , KC_C   , KC_D   , KC_V   , KC_LGUI,    KC_RGUI, KC_K   , KC_H   , KC_COMM, KC_DOT , KC_QUOT, KC_ENT ,
                                   KC_LALT, LOWER  , KC_SPC , KC_LCTL,    KC_RALT, KC_RSFT, RAISE  , KC_RCTL
    ),
    [_LOWER] = LAYOUT_split_3x7_4(
        KC_ESC , _______, KC_LBRC, KC_LCBR, KC_LPRN, KC_QUOT, _______,    _______, KC_SCLN, KC_RPRN, KC_RCBR, KC_RBRC, _______, KC_DEL ,
        KC_DOT , KC_HASH, KC_AT  , KC_EXLM, KC_QUES, KC_GRV , _______,    _______, KC_TILD, KC_MINS, KC_PLUS, KC_EQL , KC_PIPE, KC_BSPC,
        KC_LSFT, KC_CIRC, KC_AMPR, KC_DLR , KC_UNDS, CTL_TAB, KC_LGUI,    KC_RGUI, KC_BSPC, KC_PERC, KC_ASTR, KC_SLSH, KC_BSLS, KC_RSFT,
                                   KC_LALT, LOWER  , KC_SPC , KC_LCTL,    KC_RALT, KC_ENT , RAISE  , KC_RCTL 
    ),
    [_RAISE] = LAYOUT_split_3x7_4(
        KC_ESC , _______, KC_LBRC, KC_QUOT, KC_SCLN, KC_QUOT, _______,    _______, _______, _______, _______, _______, _______, KC_DEL ,
        KC_DOT , KC_1   , KC_2   , KC_3   , KC_4   , KC_5   , _______,    _______, KC_6   , KC_7   , KC_8   , KC_9   , KC_0   , KC_BSPC,
        KC_LSFT, KC_MNXT, KC_VOLD, KC_VOLU, KC_MPLY, CTL_TAB, KC_LGUI,    KC_RGUI, KC_BSPC, KC_LEFT, KC_DOWN, KC_UP  , KC_RGHT, KC_RSFT,
                                   KC_LALT, LOWER  , KC_LSFT, KC_LCTL,    KC_RALT, KC_RSFT, RAISE  , KC_RCTL 
    ),
    [_ADJUST] = LAYOUT_split_3x7_4(
        RESET  , DEBUG  , _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______, _______, _______,
        _______, KC_F11 , KC_F12 , _______, _______, _______, _______,    _______, _______, _______, _______, _______, _______, _______,
        _______, KC_F1  , KC_F2  , KC_F3  , KC_F4  , KC_F5  , KC_LGUI,    KC_RGUI, KC_F6  , KC_F7  , KC_F8  , KC_F9  , KC_F10 , _______,
                                   KC_LALT, LOWER  , KC_SPC , KC_LCTL,    KC_RALT, KC_RSFT, RAISE  , KC_RCTL 
    )
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case COLMAK:
            if (record->event.pressed) {
                set_single_persistent_default_layer(_COLMAK);
            }
            return false;
            break;
        case LOWER:
            if (record->event.pressed) {
                layer_on(_LOWER);
                update_tri_layer(_LOWER, _RAISE, _ADJUST);
            } else {
                layer_off(_LOWER);
                update_tri_layer(_LOWER, _RAISE, _ADJUST);
            }
            return false;
            break;
        case RAISE:
            if (record->event.pressed) {
                layer_on(_RAISE);
                update_tri_layer(_LOWER, _RAISE, _ADJUST);
            } else {
                layer_off(_RAISE);
                update_tri_layer(_LOWER, _RAISE, _ADJUST);
            }
            return false;
            break;
        case ADJUST:
            if (record->event.pressed) {
                layer_on(_ADJUST);
            } else {
                layer_off(_ADJUST);
            }
            return false;
            break;
    }
    return true;
}
