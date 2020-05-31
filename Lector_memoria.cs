using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using System;
using System.Text;
using System.Runtime.InteropServices;

public class Lector_memoria : MonoBehaviour
{
    // importamos la dll
    const string dllPath = "smClient64.dll";
    //declarar las funciones de las dll a utiizar en el proyecto
    [DllImport(dllPath)] // For 64 Bits System
    static extern int openMemory(String name, int type);
    // se escribe en la memoria
    [DllImport(dllPath)]
    static extern void setFloat(String memName, int position, float value);
    // se le la memoria
    [DllImport(dllPath)]
    static extern float getFloat(String memName, int position);
    // nombre de la memoria a utilizar
    private string Senales = "Senales";
    private string Sistema = "Sistema";
    // Start is called before the first frame update
    void Start()
    {
        openMemory(Senales, 2);
        openMemory(Sistema, 2);
    }

    // Update is called once per frame
    void Update()
    {
        float sp = 3;
        float Perturbacion = 0;
        float Planta=getFloat(Sistema, 0);
        float Control = getFloat(Sistema, 1);
        float Error = getFloat(Sistema, 2);
        Debug.Log(Planta);
        Debug.Log(Control);
        Debug.Log(Error);
        setFloat(Senales, 0 , sp);
        setFloat(Senales, 1, Perturbacion);
    }
}
