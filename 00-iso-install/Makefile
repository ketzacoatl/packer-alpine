clean:
	rm -rf output-virtualbox-iso
	#rm -rf output-box
	#vagrant destroy

build:
	packer build alpine-iso-install.json

add-box:
	vagrant box add alpine-clean-3.9.4 output-box/alpine-clean-3.9.4.box
