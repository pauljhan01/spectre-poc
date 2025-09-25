static inline unsigned long array_index_mask_nospec(unsigned long index,
						    unsigned long size)
{
	/*
	 * Always calculate and emit the mask even if the compiler
	 * thinks the mask is not needed. The compiler does not take
	 * into account the value of @index under speculation.
	 */
	// OPTIMIZER_HIDE_VAR(index);
    #define BITS_PER_LONG 32
	return ~(long)(index | (size - 1UL - index)) >> (BITS_PER_LONG - 1);
}

#define array_index_nospec(index, size)					\
({									\
	typeof(index) _i = (index);					\
	typeof(size) _s = (size);					\
	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
									\
	_i &= _mask;							\
	_i;								\
})