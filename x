using System;
using System.Collections;
using System.IO;

namespace KT2
{
    internal class Animal
    {
        public string name { get; protected set; }
        public int number { get; protected set; }

        public Animal(string name, int number)
        {
            this.name = name;
            this.number = number;
        }

        public virtual void Show()
        {
            Console.WriteLine("Кличка:" + name + "Телефон владельца:" + number);
        }
    }

    class NewTag : Animal
    {
        public int otdel { get; protected set; }

        public NewTag(string name, int number, int otdel) : base(name, number)
        {
            this.otdel = otdel;
        }

        public override void Show()
        {
            Console.WriteLine("Кличка: " + name + " Телефон владельца: " + number + " Отдел регистрации: " + otdel);
        }
    }

    class Program
    {
        // СРАВНИВАЕМ ИМЕНА ПИТОМЦЕВ ПО АЛФАВИТУ
        public static int Comparer(Tag x, Tag y)
        {
            return string.Compare(x.petName, y.petName);
        }

        private static void Main()
        {
            StreamReader read = new StreamReader("a.txt");
            int regsize;
            string[] input;

            regsize = Convert.ToInt32(read.ReadLine());
            Tag[] register = new Tag[regsize];

            // ВВОДИМ ИНФУ
            for (int i = 0; i < regsize; i++)
            {
                input = read.ReadLine().Split();
                if (input.Length == 2) register[i] = new Tag(input[0], input[1]);
                else register[i] = new NewTag(input[0], input[1], input[2]);
            }

            // ВЫВОДИМ ВСЮ ИНФУ
            for (int i = 0; i < regsize; i++)
            {
                Console.Write("{0}) ", i + 1);
                register[i].PrintInfo();
            }

            // ИЩЕМ ТЕЛЕФОН ВЛАДЕЛЬЦА
            bool found = false;
            string nameSearch;
            nameSearch = Console.ReadLine();
            for (int i = 0; i < regsize && !found; i++)
            {
                if (register[i].petName == nameSearch)
                {
                    found = true;
                    Console.WriteLine("Пробили телефончик! {0}", register[i].ownerPN);
                }
            }
            if (!found) Console.WriteLine("Не пробили :(");

            // ИЩЕМ НОВЫЕ БИРКИ
            foreach (Tag tag in register)
            {
                if (tag is NewTag)
                {
                    Console.WriteLine("Ого, этот тег новый");
                    tag.PrintInfo();
                }
            }

            // СОРТИРУЕМ ПО СВОЕМУ СОРТИРАТОРУ
            Array.Sort(register, Comparer);

            for (int i = 0; i < regsize; i++)
            {
                Console.Write("{0}) ", i + 1);
                register[i].PrintInfo();
            }

        }
    }
}
