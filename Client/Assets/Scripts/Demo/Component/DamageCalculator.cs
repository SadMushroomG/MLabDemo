using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DamageCalculator
{
    private static DamageCalculator instance;
    public static DamageCalculator Instance
    {
        get
        {
            if (instance == null)
            {
                instance = new DamageCalculator();
            }
            return instance;
        }
    }

    public void CalculateDamage(BulletBase bullet, ActorBase attackedActor)
    {

    }
}
