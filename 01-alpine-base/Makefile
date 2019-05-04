# add $NAME variable, set to alpine-base, and also $VERSION to 3.6.1
build:
	packer build -force alpine-base.json

clean:
	#rm -rf
	vagrant box remove alpine-base-3.9.3

add-box:
	vagrant box add alpine-base-3.9.3 output-box/alpine-base-3.9.3.box

vlist:
	vagrant box list
