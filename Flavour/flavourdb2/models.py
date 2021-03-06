from django.db import models

# Create your models here.

class User(models.Model):
	name = models.CharField(max_length=200, default = '')
	surName = models.CharField(max_length=200, default = '')


class Comuna(models.Model):
	name = models.CharField(max_length=60, default = '')
	def __unicode__(self):
		return "{}".format(self.name)

class Chef(models.Model):
	name = models.CharField(max_length=60, default = '')
	lastname = models.CharField(max_length=60, default = '')
	email = models.EmailField(max_length=60)
	phone = models.CharField(max_length=12)
	pictureUrl = models.URLField(max_length=200)
	description = models.CharField(max_length=200, default='')
	comunas = models.ManyToManyField(Comuna)
	def __unicode__(self):
		return "{} {} | {}".format(self.name, self.lastname, self.description)

class Consumer(models.Model):
	name = models.CharField(max_length=60, default = '')
	lastname = models.CharField(max_length=60, default = '')
	address = models.CharField(max_length=60, default = '')
	phone = models.CharField(max_length=12, default = '')
	FBID = models.CharField(max_length=60, default = '', blank=True)
	email = models.EmailField(max_length=60, default = '')
	comuna = models.ForeignKey(Comuna)

	

class ChefBioFoodImage(models.Model):
	url = models.URLField(max_length=200)
	chef = models.ForeignKey(Chef)
	def __unicode__(self):
		return "{}".format(self.url)

class Menu(models.Model):
	name = models.CharField(max_length=200, default='')
	description = models.CharField(max_length=200, default='')
	precio = models.IntegerField(default=0)
	preparationTime = models.IntegerField(default=0)
	def __unicode__(self):
		return "${} | {}".format(self.precio, self.description)

class MenuImage(models.Model):
	url = models.URLField(max_length=200)
	menu = models.ForeignKey(Menu)
	def __unicode__(self):
		return "{}".format(self.url)