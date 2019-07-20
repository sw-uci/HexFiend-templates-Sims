# see TS4 CC Guide.pdf
# https://www.wiki.sc4devotion.com/index.php?title=Spore_DBPF
requires 0 "44425046"
little_endian
section "Header" {
	uint32; # DBPF
	uint32 "File Major"
	uint32 "File Minor"
	uint32 "User Major"
	uint32 "User Minor"
	uint32; # "null"
	uint32 "Creation Time"
	uint32 "Updated Time"
	uint32; # "null"
	set entries [uint32 "IndexRecordEntryCount"]
	uint32 "IndexRecordPositionLow"
	uint32 "IndexRecordSize"
	uint32; # "null"
	uint32; # "null"
	uint32; # "null"
	uint32; # "unused (3)"
	set idxpos [uint64 "IndexRecordPosition"]
	uint32 "null"
	uint32 "null"
	uint32 "null"
	uint32 "null"
	uint32 "null"
	uint32 "null"
}
goto $idxpos
section "Index" {
	set IndexType [uint32 -hex "Type"]
	if {$IndexType == 6} {
		uint32 -hex "type"
		# uint32 -hex "InstanceEx"
		uint32 -hex "reserved"
		for {set i 0} {$i < $entries} {incr i} {
			section "IndexEntry" {
				uint32 "group?"
				uint32 "Instance?"
				uint32 "Position"

				# uint32 "Size"
				set s [uint32]
				entry "Size" [expr $s & 2147483647]; # &0x7fffffff]

				# uint32 "ExtendedCompressionType"
				uint32 "SizeDecompressed"
				uint16 -hex "IsCompressed"
				uint16 "Committed"
			}
		}
	} elseif {$IndexType == 7} {
		uint32 -hex "Group"
		uint32 -hex "InstanceEx"
		uint32 -hex "reserved"
		for {set i 0} {$i < $entries} {incr i} {
			section "IndexEntry" {
				uint32 "Instance"
				uint32 "Position"

				# uint32 "Size"
				set s [uint32]
				entry "Size" [expr $s & 2147483647]; # &0x7fffffff]

				# uint32 "ExtendedCompressionType"
				uint32 "SizeDecompressed"
				uint16 -hex "IsCompressed"
				uint16 "Committed"
			}
		}
	}
}


if {$IndexType == 6} {
	section "RawRecords" {
		for {set i 0} {$i < $entries} {incr i} {
			goto [expr [expr $idxpos + 20] + [expr 24 * $i]]
			set offset [uint32]
			set size [expr [uint32] & 2147483647]
			# set decompressedsize [uint32]
			goto $offset
			section $offset {
				uint16 -hex "CompressionType"
				hex 3 "SizeDecompressed"; # big endian
				bytes [expr $size - 5] "data"
			}
		}
	}
} elseif {$IndexType == 7} {
	section "RawRecords" {
		for {set i 0} {$i < $entries} {incr i} {
			goto [expr [expr $idxpos + 20] + [expr 20 * $i]]
			set offset [uint32]
			set size [expr [uint32] & 2147483647]
			# set decompressedsize [uint32]
			goto $offset
			section $offset {
				uint16 -hex "CompressionType"
				hex 3 "SizeDecompressed"; # big endian
				bytes [expr $size - 5] "data"
			}
		}
	}
}
