using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TempConfig : MonoBehaviour
{
    private static TempConfig instance;
    
    public static TempConfig Instance
    {
        get 
        {
            if (instance == null)
            {
                instance = GameObject.FindObjectOfType<TempConfig>();
            }
            return instance; 
        }
    }

    //default PawnWeapon
    public WeaponBase defaultPawnWeapon;
    //default BuildingWeapon 
    public WeaponBase defaultBuildingWeapon;
}
