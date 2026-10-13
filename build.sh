echo "Build start"
ld ../TypeConverters/type_converters.o std_io.o main.o -o program

if [ $? -ne 0 ]; then
	echo "!! Build failed."
	exit 1
fi

echo "Build complete"
