# Creates a new array data structure.
#
# Arguments:
#  1. name: Required. The array name.
#
function _do_array_new() {
    local name=${1?'name arg required'}

    # Makes sure that the array not yet exists
    ! _do_array_exists "${name}" || _do_assert_fail "${name} array already exists."

    local var_name=$(_do_array_var_name ${name})
    declare -ag "${var_name}"
}


# Destroys an array data structure
#
# Arguments:
#  1. name: Required. The array name.
#
function _do_array_destroy() {
    local name=${1?'name arg required'}
    local var_name=$(_do_array_var_name_required ${name})

    unset "${var_name}"
}


# Checks if an array exists.
#
# Arguments:
#   1. name: Required. The array name.
#
# Returns:
#   0 if the array exists; Otherwise, 1.
#
function _do_array_exists() {
    local name=${1?'name arg required'}
    local var_name=$(_do_array_var_name ${name})

    if [[ -v "${var_name}" ]]; then
        return 0
    else
        return 1
    fi
}


# Checks if the specified item exists in the array.
# 
# Arguments: 
# 1. name: Required. The array name.
# 2. val: Required. The value to find in the array. 
#
# Returns:
#   If the array contains the specified value, returns 0.
#   Otherwise, return 1.
# 
function _do_array_contains() {
   echo "TODO" 

}

# Gets the index of the specified value in an array data structure.
# 
# Arguments: 
# 1. name: Required. The array name.
# 2. val: Required. The value to find in the array. 
#
# Output:
#   If the array contains the specified value, echo the index.
#   Otherwise, echo -1.
# 
function _do_array_index_of() {
    local name=$(_do_array_var_name_required $1)
    local val=${2?'val arg required'}
}


# Get the size of a array
#
# Arguments: 
#   1. The array name.
#   2. The variable name to contains the size.
#
function _do_array_size() {
    local name=${1?'name arg required'}
    local var_name=$(_do_array_var_name_required ${name})

    _do_assert ${var_name}

    local size
    eval "size"='$'"{#${var_name}[@]}"
    echo "${size}"
}



# Append 1 more item to the array
#
# Arguments: 
#   1. name: The array name
#   ... values: One value or more to append.
#
function _do_array_append() {
    local name=${1?'name arg required'}
    local var_name=$(_do_array_var_name_required "${name}")

    local size=$(_do_array_size $name)
    shift 1

    # Makes sure there is at list 1 item to append
    : ${1?'Missing item(s) to append'}

    # Reads all remaining values and push to stack
    while (( $# > 0 )); do
        # Appends to the current items to the end of the array.
        eval "${var_name}[$size]='$1'"
        let size+=1

        shift 1
    done
}


# Converts a logical array name to the physical one.
# 
# Arguments:
#  1. name: Required. The logical array name.
#
# Output:
#  The physical array name.
#
function _do_array_var_name() {
    local name=${1?'name arg required'}
    echo "__do_array_${name}"
}


# Converts a logical array name to the physical one and make sure
# that array does exist.
#
# Arguments:
#  1. name: Required. The array logical name.
#
# Outputs:
#  The array physical name.
#
function _do_array_var_name_required() {
    local name=${1?'name arg required'}

    # _do_array_exists "${name}" || _do_assert_fail "${name} array doest not exist"

    echo "$(_do_array_var_name ${name})"
}

