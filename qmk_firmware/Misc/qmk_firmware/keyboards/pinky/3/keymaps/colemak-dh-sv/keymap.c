/* Copyright 2018 'Masayuki Sunahara'
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H
#include "keymap_swedish.h"

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
        KC_ESC , KC_Q   , KC_W   , KC_F   , KC_P   , KC_B   , KC_LPRN,    _______, KC_J   , KC_L   , KC_U   , KC_Y   , SE_LABK, KC_DEL ,
        CTL_TAB, KC_A   , KC_R   , KC_S   , KC_T   , KC_G   , KC_LBRC,    KC_RBRC, KC_M   , KC_N   , KC_E   , KC_I   , KC_O   , KC_BSPC,
        KC_LSFT, KC_Z   , KC_X   , KC_C   , KC_D   , KC_V   , KC_LGUI,    KC_RGUI, KC_K   , KC_H   , KC_COMM, KC_DOT , SE_MINS, KC_ENT ,
                                   KC_LALT, LOWER  , KC_SPC , KC_LCTL,    KC_RALT, KC_RSFT, RAISE  , KC_RCTL
    ),
    [_LOWER] = LAYOUT_split_3x7_4(
        KC_ESC , _______, SE_LBRC, SE_LCBR, SE_LPRN, SE_QUOT, _______,    _______, SE_SCLN, SE_RPRN, SE_RCBR, SE_RBRC, _______, KC_DEL ,
        _______, SE_HASH, SE_AT  , SE_EXLM, SE_QUES, SE_GRV , _______,    _______, SE_TILD, SE_QUOT, SE_PLUS, SE_EQL , SE_PIPE, KC_BSPC,
        KC_LSFT, SE_CIRC, SE_AMPR, SE_DLR , SE_DQUO, CTL_TAB, KC_LGUI,    KC_RGUI, KC_BSPC, SE_PERC, SE_ASTR, SE_SLSH, SE_BSLS, KC_RSFT,
                                   KC_LALT, LOWER  , KC_SPC , KC_LCTL,    KC_RALT, KC_ENT , RAISE  , KC_RCTL 
    ),
    [_RAISE] = LAYOUT_split_3x7_4(
        KC_ESC , _______, SE_ARNG, SE_ADIA, SE_ODIA, KC_QUOT, _______,    _______, _______, _______, _______, _______, _______, KC_DEL ,
        _______, SE_1   , SE_2   , SE_3   , SE_4   , SE_5   , _______,    _______, SE_6   , SE_7   , SE_8   , SE_9   , SE_0   , KC_BSPC,
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
